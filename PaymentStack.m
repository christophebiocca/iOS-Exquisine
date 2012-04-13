//
//  PaymentStack.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentStack.h"
#import "LocationState.h"

#import "PaymentConfirmationController.h"
#import "PaymentInfoViewController.h"
#import "PaymentProcessingViewController.h"
#import "PaymentCompleteViewController.h"
#import "PaymentFailureViewController.h"
#import "OrderTimeAndLocationConfirmationViewController.h"
#import "PlaceOrder.h"
#import "GetPaymentProfileInfo.h"
#import "DeletePaymentInfo.h"
#import "PaymentProfileInfo.h"
#import "PaymentError.h"
#import "Order.h"

#import "PaymentInfo.h"
#import "FancyNavigationController.h"

@interface PaymentStack(PrivateMethods)

/* Controllers in use */
@property(retain, readonly)PaymentProcessingViewController* preProcessingController;
@property(retain, readonly)PaymentInfoViewController* paymentInfoController;
@property(retain, readonly)PaymentProcessingViewController* processingController;
@property(retain, readonly)PaymentCompleteViewController* completionController;
@property(retain, readonly)PaymentConfirmationController* paymentConfirmationController;
@property(retain, readonly)PaymentFailureViewController* failureController;
@property(retain, readonly)OrderTimeAndLocationConfirmationViewController* locationConfirmationController;

/* Stack states */
-(void)checkForProfile;
-(void)requestConfirmation;
-(void)requestPaymentInfo;
-(void)changePaymentInfo;
-(void)sendOrder:(PaymentInfo*)payment;
-(void)showSuccess;
-(void)showFailure:(NSError*)error;

/* Animation Control */
-(void)pushController:(UIViewController*)controller;
-(void)afterAnimating:(void(^)())after;

@end

@implementation PaymentStack

- (id)initWithOrder:(Order*)orderToPlace
          locationState:(LocationState*)theLocationState 
       successBlock:(void (^)())success
    completionBlock:(void(^)())completion 
  cancellationBlock:(void(^)())cancelled
{
    if (self = [super init]) {
        order = orderToPlace;
        locationState = theLocationState;
        successBlock = [success copy];
        void (^complete)() = [completion copy];
        completionBlock = [^{
            complete();
            [navigationController setDelegate:nil];
        } copy];
        void (^cancel)() = [cancelled copy];
        cancelledBlock = [^{
            cancel();
            [navigationController setDelegate:nil];
        } copy];
        postAnimation = [NSMutableArray new];
        [self performSelectorOnMainThread:@selector(confirmLocationAndTime) withObject:nil waitUntilDone:NO];
    }
    return self;
}

#pragma mark -
#pragma mark Controllers

-(UINavigationController*)navigationController{
    if(!navigationController){
        navigationController = [[FancyNavigationController alloc] initWithRootViewController:[self locationConfirmationController]];
        [navigationController setDelegate:self];
    }
    return navigationController;
}

-(PaymentProcessingViewController*)preProcessingController{
    if(!preProcessingController){
        preProcessingController = [[PaymentProcessingViewController alloc] init];
    }
    return preProcessingController;
}

-(PaymentConfirmationController*)paymentConfirmationController{
    if(!paymentConfirmationController){
        paymentConfirmationController = [[PaymentConfirmationController alloc] init];
    }
    return paymentConfirmationController;
}

-(PaymentInfoViewController*)paymentInfoController{
    if(!paymentInfoController){
        paymentInfoController = [[PaymentInfoViewController alloc] init];
    }
    return paymentInfoController;
}


-(PaymentProcessingViewController*)processingController{
    if(!processingController){
        processingController = [[PaymentProcessingViewController alloc] init];
    }
    return processingController;
}

-(PaymentCompleteViewController*)completionController{
    if(!completionController){
        completionController = [[PaymentCompleteViewController alloc] init];
    }
    return completionController;
}

-(PaymentFailureViewController*)failureController{
    if(!failureController){
        failureController = [[PaymentFailureViewController alloc] init];
    }
    return failureController;
}

-(OrderTimeAndLocationConfirmationViewController *) locationConfirmationController
{
    if (!locationConfirmationController)
    {
        locationConfirmationController = [[OrderTimeAndLocationConfirmationViewController alloc] initWithLocationState:locationState AndOrder: order];
    }
    return locationConfirmationController;
}
    
#pragma mark Stack States

-(void)confirmLocationAndTime
{
    OrderTimeAndLocationConfirmationViewController *controller = [self locationConfirmationController];
    
    [controller setDoneBlock:^(void){
        [self checkForProfile];
    }];
    
    [controller setCancelledBlock:^(void){
        cancelledBlock();
    }];
     
    
    [self afterAnimating:^{
        [[self navigationController] setViewControllers:[NSArray arrayWithObject:controller] 
                                               animated:YES];
    }];
    
    
}

-(void)checkForProfile{
    [self pushController:[self preProcessingController]];
    [GetPaymentProfileInfo fetchInfo:^(GetPaymentProfileInfo* request){
        CLLog(LOG_LEVEL_INFO, [NSString stringWithFormat:@"Success %@", self]);
        [[self paymentConfirmationController] setCcDigits:[[request info] last4Digits]];
        [self requestConfirmation];
    } failure:^(GetPaymentProfileInfo* info, NSError* error){
        if([[error domain] isEqualToString:JSON_API_ERROR] && 
           [[[error userInfo] objectForKey:@"class"] isEqualToString:@"NoPaymentInfoError"]){
            [self requestPaymentInfo];
        } else {
            [self showFailure:error];
        }
    }];
}

-(void)requestConfirmation{
    PaymentConfirmationController* controller = [self paymentConfirmationController];
    [self pushController:controller];
    [controller setAcceptBlock:^{
        UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Process Purchase?" message:[NSString stringWithFormat: @"Order confirmation:\nSubtotal: %@\nHST: %@\nGrand Total: %@\n\nIs this okay?", [Utilities FormatToPrice:[order subtotalPrice]],[Utilities FormatToPrice:[order taxPrice]],[Utilities FormatToPrice:[order totalPrice]]] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        
        [areYouSure setTag:1];
        
        [areYouSure show];
    }];
    [controller setCancelBlock:^{
        cancelledBlock();
    }];
    [controller setChangeBlock:^{
        [self changePaymentInfo];
    }];
}

-(void)requestPaymentInfo{
    PaymentInfoViewController* controller = [self paymentInfoController];
    [self pushController:controller];
    [controller setCompletionBlock:^(PaymentInfo* info){
        paymentInfo = info;
        UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Process Purchase?" message:[NSString stringWithFormat: @"Order confirmation:\nSubtotal: %@\nHST: %@\nGrand Total: %@\n\nIs this okay?", [Utilities FormatToPrice:[order subtotalPrice]],[Utilities FormatToPrice:[order taxPrice]],[Utilities FormatToPrice:[order totalPrice]]] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        
        [areYouSure setTag:2];
        
        [areYouSure show];
    }];
    [controller setCancelledBlock:^{
        cancelledBlock();
    }];
}

-(void)changePaymentInfo{
    PaymentInfoViewController* controller = [self paymentInfoController];
    [self pushController:controller];
    [controller setCompletionBlock:^(PaymentInfo* info){
        paymentInfo = info;
        UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Process Purchase?" message:[NSString stringWithFormat: @"Order confirmation:\nSubtotal: %@\nHST: %@\nGrand Total: %@\n\nIs this okay?", [Utilities FormatToPrice:[order subtotalPrice]],[Utilities FormatToPrice:[order taxPrice]],[Utilities FormatToPrice:[order totalPrice]]] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        
        [areYouSure setTag:2];
        
        [areYouSure show];
    }];
    [controller setCancelledBlock:^{
        //I'm aware of how bad this looks, but it's to work around an iOS bug.
        
        NSMutableArray *newControllers = [NSMutableArray arrayWithArray:[navigationController viewControllers]];
        [newControllers removeObject:[newControllers lastObject]];
        [navigationController setViewControllers:newControllers animated:YES];
    }];
}

-(void)sendOrder:(PaymentInfo*)info{
    [self pushController:[self processingController]];
    [PlaceOrder sendOrder:order toLocation:[self currentLocation] withPaymentInfo:info 
           paymentSuccess:^(PaymentSuccessInfo* success){
               successBlock();
               [[self completionController] setSuccessInfo:success AndOrder:order];
               if(info && (![info remember])){
                   [DeletePaymentInfo deletePaymentInfo:^(DeletePaymentInfo* delete) {
                       CLLog(LOG_LEVEL_DEBUG, @"Successfully deleted payment info.");
                   } failure:^(DeletePaymentInfo* delete, NSError* error){
                       CLLog(LOG_LEVEL_ERROR, @"Got an error when deleting payment info.");
                   }];
               }
               [self showSuccess];
           } 
           paymentFailure:^(PaymentError* error){
               if([error isUserError]){
                   [[self paymentInfoController] setError:error];
                   [self requestPaymentInfo];
               } else {
                   [self showFailure:[error cause]];
               }
           }];
}

-(void)showSuccess{
    PaymentCompleteViewController* controller = [self completionController];
    [self pushController:controller];
    [controller setDoneCallback:^{
        completionBlock();
    }];
}

-(void)showFailure:(NSError*)error{
    PaymentFailureViewController* controller = [self failureController];
    [controller setError:error];
    [self pushController:controller];
    [controller setCancelCallback:^{
        cancelledBlock();
    }];
}

#pragma mark Animation Control

-(void)pushController:(UIViewController*)controller{
    [self afterAnimating:^{
        NSMutableArray* currentControllers = [NSMutableArray arrayWithArray:[[self navigationController] viewControllers]];
        [currentControllers removeObjectIdenticalTo:[self preProcessingController]];
        [currentControllers removeObjectIdenticalTo:[self processingController]];
        [currentControllers addObject:controller];
        [[self navigationController] setViewControllers:currentControllers animated:YES];
    }];
}

-(void)navigationController:(UINavigationController *)navigationController 
     willShowViewController:(UIViewController *)viewController 
                   animated:(BOOL)animated{
    if(animated){
        @synchronized(self){
            animating = YES;
        }
    }
}
-(void)navigationController:(UINavigationController *)navigationController 
      didShowViewController:(UIViewController *)viewController 
                   animated:(BOOL)animated{
    if(animated){
        @synchronized(self){
            animating = NO;
            for(void(^postAnimationBlock)() in postAnimation){
                postAnimationBlock();
            }
            [postAnimation removeAllObjects];
        }
    }
}

-(void)afterAnimating:(void (^)())after{
    @synchronized(self){
        if(animating){
            [postAnimation addObject:[after copy]];
        } else {
            after();
        }
    }
}

-(Location *)currentLocation
{
    return [locationState selectedLocation];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if([alertView tag] == 1)
        {
            [self sendOrder:nil];
        }
        if ([alertView tag] == 2) {
            [self sendOrder:paymentInfo];
        }
    }
}

@end
