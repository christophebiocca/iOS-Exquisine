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
@class PaymentInfoViewController;
@class PaymentConfirmationController;
@class PaymentProcessingViewController;
@class PaymentCompleteViewController;

@interface PaymentStack : NSObject<UINavigationControllerDelegate>{
    Order* order;
    Location* location;
    
    UINavigationController* navigationController;
    PaymentProcessingViewController* preProcessingController;
    PaymentConfirmationController* paymentConfirmationController;
    PaymentInfoViewController* paymentInfoController;
    PaymentProcessingViewController* processingController;
    PaymentCompleteViewController* completionController;
    
    void(^completionBlock)();
    void(^cancelledBlock)();
    
    /* Animation Management */
    BOOL animating;
    NSMutableArray* postAnimation;
}

@property(retain, readonly)UINavigationController* navigationController;

-(id)initWithOrder:(Order*)order locations:(NSArray*)locations completionBlock:(void(^)())completion cancellationBlock:(void(^)())cancelled;

-(void)afterAnimating:(void(^)())after;

@end
