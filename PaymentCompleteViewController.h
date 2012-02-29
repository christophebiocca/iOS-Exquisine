//
//  PaymentCompleteViewController.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class PaymentSuccessInfo;
@class PaymentCompletedView;
@class Order;

@interface PaymentCompleteViewController : UIViewController{
    PaymentSuccessInfo* successInfo;
    PaymentCompletedView* paymentView;
    Order *theOrder;
    void (^doneCallback)();
}

@property(copy, nonatomic)void(^doneCallback)();
-(void)setSuccessInfo:(PaymentSuccessInfo*)info AndOrder:(Order *) anOrder;

@end
