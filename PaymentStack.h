//
//  PaymentStack.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaymentStack : NSObject
@class Order;
@class Location;
@class PaymentInfoViewController;
@class PaymentProcessingViewController;
@class PaymentCompleteViewController;

@interface PaymentStack : NSObject<UINavigationControllerDelegate>{
    Order* order;
    
    UINavigationController* navigationController;
    PaymentInfoViewController* paymentInfoController;
    PaymentProcessingViewController* processingController;
    PaymentCompleteViewController* completionController;
    
    Location* location;
    NSError* locationError;
    
    void(^completionBlock)();
    void(^cancelledBlock)();
}

@property(retain, readonly)UINavigationController* navigationController;

-(id)initWithOrder:(Order*)order completionBlock:(void(^)())completion cancellationBlock:(void(^)())cancelled;

@end
