//
//  PaymentConfirmationController.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListViewController.h"

@class PaymentConfirmationView;
@class PaymentProfileInfo;
@class Order;

@interface PaymentConfirmationController : ListViewController
{
    Order *theOrder;
    PaymentProfileInfo *paymentProfile;
    NSString* ccDigits;
    void (^acceptBlock)();
    void (^changeBlock)();
    void (^cancelBlock)();
}

-(void)setPaymentInfo:(PaymentProfileInfo *)payment;

-(id)initWithPaymentInfo:(PaymentProfileInfo *)profile andOrder:(Order *)anOrder;

@property(copy, nonatomic)void (^acceptBlock)();
@property(copy, nonatomic)void (^changeBlock)();
@property(copy, nonatomic)void (^cancelBlock)();

@end
