//
//  PaymentCompleteViewController.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class PaymentSuccessInfo;
@class PaymentCompletedView;

@interface PaymentCompleteViewController : UIViewController{
    PaymentSuccessInfo* successInfo;
    PaymentCompletedView* paymentView;
    void (^done)();
}

-(id)initWithDoneCallback:(void(^)())doneCallback;
-(void)setSuccessInfo:(PaymentSuccessInfo*)info;

@end
