//
//  PaymentConfirmationRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListRenderer.h"
@class PaymentProfileInfo;
@class Order;

@interface PaymentConfirmationRenderer : ListRenderer
{
    Order *theOrder;
    PaymentProfileInfo *thePaymenyProfile;
}

-(id)initWithPaymentInfo:(PaymentProfileInfo *)profile andOrder:(Order *)anOrder;

@end
