//
//  ShinyPaymentProfileRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListRenderer.h"
@class PaymentProfileInfo;

@interface ShinyPaymentProfileRenderer : ListRenderer

-(id)initWithPaymentInfo:(PaymentProfileInfo *)paymentInfo;

@end
