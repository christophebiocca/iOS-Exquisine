//
//  PaymentInfoViewController.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class PaymentInfo;
@class PaymentView;
@class PaymentError;
@class Order;

@interface PaymentInfoViewController : UIViewController<UITextFieldDelegate>{
    PaymentView* paymentView;
    PaymentInfo* info;
    
    void(^completionBlock)(PaymentInfo*);
    void(^cancelledBlock)();
}

-(id)init;

@property(retain) PaymentView *paymentView;

@property(copy, nonatomic)void(^completionBlock)(PaymentInfo*);
@property(copy, nonatomic)void(^cancelledBlock)();

-(void)setError:(PaymentError*)error;

@end
