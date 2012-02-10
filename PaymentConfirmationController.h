//
//  PaymentConfirmationController.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class PaymentConfirmationView;

@interface PaymentConfirmationController : UIViewController{
    PaymentConfirmationView* paymentView;
    
    NSString* ccDigits;
    void (^acceptBlock)();
    void (^changeBlock)();
    void (^cancelBlock)();
}

-(id)init;

@property(retain, nonatomic)NSString* ccDigits;
@property(copy, nonatomic)void (^acceptBlock)();
@property(copy, nonatomic)void (^changeBlock)();
@property(copy, nonatomic)void (^cancelBlock)();

@end
