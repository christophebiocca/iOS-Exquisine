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

-(id)initWithCCDigits:(NSString*)digits accept:(void(^)())accept change:(void(^)())change cancel:(void(^)())cancel;

@end
