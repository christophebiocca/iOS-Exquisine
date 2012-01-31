//
//  PaymentInfoViewController.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class PaymentInfo;
@class PaymentView;

@interface PaymentInfoViewController : UIViewController{
    PaymentView* paymentView;
    void(^completionBlock)(PaymentInfo*);
    void(^cancelledBlock)();
}

- (id)initWithCompletionBlock:(void(^)(PaymentInfo*))completion cancellationBlock:(void(^)())cancelled;

@end
