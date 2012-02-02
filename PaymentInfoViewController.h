//
//  PaymentInfoViewController.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentViewDelegate.h"

@class PaymentInfo;
@class PaymentView;
@class PaymentError;
@class Order;

@interface PaymentInfoViewController : UIViewController<PaymentViewDelegate>{
    PaymentView* paymentView;
    PaymentInfo* info;
    
    void(^completionBlock)(PaymentInfo*);
    void(^cancelledBlock)();
}

-(id)initWithCompletionBlock:(void(^)(PaymentInfo*))completion cancellationBlock:(void(^)())cancelled;

-(void)setError:(PaymentError*)error;

@end
