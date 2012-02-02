//
//  PaymentStack.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentStack.h"
#import "GetLocations.h"
#import "PaymentInfoViewController.h"
#import "PaymentProcessingViewController.h"
#import "PlaceOrder.h"
#import "PaymentCompleteViewController.h"

@interface PaymentStack(PrivateMethods)

@property(retain, readonly)PaymentInfoViewController* paymentInfoController;
@property(retain, readonly)PaymentProcessingViewController* processingController;
@property(retain, readonly)PaymentCompleteViewController* completionController;

-(void)sendOrder:(PaymentInfo*)payment;

@end

@implementation PaymentStack

- (id)initWithOrder:(Order*)orderToPlace
           location:(Location*)locationToUse 
    completionBlock:(void(^)())completion 
  cancellationBlock:(void(^)())cancelled
{
    if (self = [super init]) {
        order = orderToPlace;
        completionBlock = [completion copy];
        cancelledBlock = [cancelled copy];
    }
    return self;
}

-(UINavigationController*)navigationController{
    if(!navigationController){
        navigationController = [[UINavigationController alloc] initWithRootViewController:[self paymentInfoController]];
    }
    return navigationController;
}

-(PaymentInfoViewController*)paymentInfoController{
    if(!paymentInfoController){
        paymentInfoController = [[PaymentInfoViewController alloc] initWithCompletionBlock:^(PaymentInfo* info){
            [[self navigationController] pushViewController:[self processingController] animated:YES];
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
               [[self navigationController] pushViewController:complete animated:YES];
           } 
           paymentFailure:^(PaymentError* error){
               [[self paymentInfoController] setError:error];
           }];
}

-(PaymentProcessingViewController*)processingController{
    if(!processingController){
        
    }
    return processingController;
}

-(PaymentCompleteViewController*)completionController{
    if(!completionController){
        
    }
    return completionController;
}

@end
