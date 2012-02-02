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
@class PaymentProcessingViewController;
@class PaymentCompleteViewController;

@interface PaymentStack : NSObject<UINavigationControllerDelegate>{
    Order* order;
    Location* location;
    
    UINavigationController* navigationController;
    PaymentInfoViewController* paymentInfoController;
    PaymentProcessingViewController* processingController;
    PaymentCompleteViewController* completionController;
    
    void(^completionBlock)();
    void(^cancelledBlock)();
}

@property(retain, readonly)UINavigationController* navigationController;

-(id)initWithOrder:(Order*)order location:(Location*)locationToUse completionBlock:(void(^)())completion cancellationBlock:(void(^)())cancelled;

@end
