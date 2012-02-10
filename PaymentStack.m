//
//  PaymentStack.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentStack.h"

#import "PaymentConfirmationController.h"
#import "PaymentInfoViewController.h"
#import "PaymentProcessingViewController.h"
#import "PaymentCompleteViewController.h"

#import "PlaceOrder.h"
#import "GetPaymentProfileInfo.h"
#import "PaymentProfileInfo.h"

@interface PaymentStack(PrivateMethods)

@property(retain, readonly)PaymentProcessingViewController* preProcessingController;
@property(retain, readonly)PaymentInfoViewController* paymentInfoController;
@property(retain, readonly)PaymentProcessingViewController* processingController;
@property(retain, readonly)PaymentCompleteViewController* completionController;
-(PaymentConfirmationController*)paymentConfirmationControllerForDigits:(NSString*)digits;

-(void)queryPaymentInfo;
-(void)sendOrder:(PaymentInfo*)payment;

@end

@implementation PaymentStack

- (id)initWithOrder:(Order*)orderToPlace
          locations:(NSArray*)locations 
    completionBlock:(void(^)())completion 
  cancellationBlock:(void(^)())cancelled
{
    if (self = [super init]) {
        order = orderToPlace;
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
        NSAssert([locations count] == 1, @"Expected exactly one location. (Got %@)", locations);
        location = [locations lastObject];
        postAnimation = [NSMutableArray new];
        [self performSelectorOnMainThread:@selector(queryPaymentInfo) withObject:nil waitUntilDone:NO];
    }
    return self;
}

-(void)queryPaymentInfo{
    [GetPaymentProfileInfo fetchInfo:^(GetPaymentProfileInfo* request){
        CLLog(LOG_LEVEL_INFO, [NSString stringWithFormat:@"Success %@", self]);
        [[self navigationController] pushViewController:[self paymentConfirmationControllerForDigits:[[request info] last4Digits]] animated:YES];
    } failure:^(GetPaymentProfileInfo* info, NSError* error){
        if([[error domain] isEqualToString:JSON_API_ERROR] && 
           [[[error userInfo] objectForKey:@"class"] isEqualToString:@"NoPaymentInfoError"]){
            [self afterAnimating:^{
                [[self navigationController] pushViewController:[self paymentInfoController] animated:YES];
            }];
        } else {
            cancelledBlock();
        }
    }];
}

-(UINavigationController*)navigationController{
    if(!navigationController){
        navigationController = [[UINavigationController alloc] initWithRootViewController:[self preProcessingController]];
        [navigationController setNavigationBarHidden:YES];
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

-(PaymentConfirmationController*)paymentConfirmationControllerForDigits:(NSString*)digits{
    if(!paymentConfirmationController){
        paymentConfirmationController = [[PaymentConfirmationController alloc] 
                                         initWithCCDigits:digits 
                                         accept:^{
                                             NSArray* controllers = [[self navigationController] viewControllers];
                                             controllers = [controllers arrayByAddingObjectsFromArray:
                                                            [NSArray arrayWithObjects:
                                                             [self paymentInfoController], 
                                                             [self processingController], 
                                                             nil]];
                                             [[self navigationController] setViewControllers:controllers animated:YES];
                                             [self sendOrder:nil];
                                         } 
                                         change:^{
                                             [self afterAnimating:^{
                                                 [[self navigationController] pushViewController:[self paymentInfoController] animated:YES];
                                             }];
                                         }
                                         cancel:^{
                                             cancelledBlock();
                                         }];
    }
    return paymentConfirmationController;
}

-(PaymentInfoViewController*)paymentInfoController{
    if(!paymentInfoController){
        paymentInfoController = [[PaymentInfoViewController alloc] initWithCompletionBlock:^(PaymentInfo* info){
            [self afterAnimating:^{
                [[self navigationController] pushViewController:[self processingController] animated:YES];
            }];
            [self sendOrder:info];
        } cancellationBlock:^{
            cancelledBlock();
        }];
    }
    return paymentInfoController;
}

-(void)sendOrder:(PaymentInfo*)info{
    [PlaceOrder sendOrder:order toLocation:location withPaymentInfo:info 
           paymentSuccess:^(PaymentSuccessInfo* success){
               PaymentCompleteViewController* complete = [self completionController];
               [complete setSuccessInfo:success];
               [self afterAnimating:^{
                   [[self navigationController] pushViewController:complete animated:YES];
               }];
           } 
           paymentFailure:^(PaymentError* error){
               PaymentInfoViewController* info = [self paymentInfoController];
               [info setError:error];
               [self performSelector:@selector(afterAnimating:) withObject:[^{
                   [[self navigationController] popToViewController:info animated:YES];
               } copy] afterDelay:2];
           }];
}

-(PaymentProcessingViewController*)processingController{
    if(!processingController){
        processingController = [[PaymentProcessingViewController alloc] init];
    }
    return processingController;
}

-(PaymentCompleteViewController*)completionController{
    if(!completionController){
        completionController = [[PaymentCompleteViewController alloc] initWithDoneCallback:^{
            completionBlock();
        }];
    }
    return completionController;
}

/* Animation Control */

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

@end
