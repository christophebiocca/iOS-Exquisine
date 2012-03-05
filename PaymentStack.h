//
//  PaymentStack.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Order;
@class Location;
@class LocationState;
@class OrderTimeAndLocationConfirmationViewController;
@class PaymentInfoViewController;
@class PaymentConfirmationController;
@class PaymentProcessingViewController;
@class PaymentCompleteViewController;
@class PaymentFailureViewController;

@interface PaymentStack : NSObject<UINavigationControllerDelegate>{
    Order* order;
    LocationState *locationState;
    
    UINavigationController* navigationController;
    OrderTimeAndLocationConfirmationViewController *locationConfirmationController;
    PaymentProcessingViewController* preProcessingController;
    PaymentConfirmationController* paymentConfirmationController;
    PaymentInfoViewController* paymentInfoController;
    PaymentProcessingViewController* processingController;
    PaymentCompleteViewController* completionController;
    PaymentFailureViewController* failureController;
    
    void(^successBlock)();
    void(^completionBlock)();
    void(^cancelledBlock)();
    
    /* Animation Management */
    BOOL animating;
    NSMutableArray* postAnimation;
}

@property(retain, readonly)UINavigationController* navigationController;

- (id)initWithOrder:(Order*)orderToPlace
      locationState:(LocationState*)theLocationState 
       successBlock:(void (^)())success
    completionBlock:(void(^)())completion 
  cancellationBlock:(void(^)())cancelled;

-(Location *) currentLocation;

@end
