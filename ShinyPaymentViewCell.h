//
//  ShinyPaymenyViewCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"
@class PaymentProfileInfo;

@interface ShinyPaymentViewCell : CustomViewCell
{
    PaymentProfileInfo *paymentInfo;
    UIImageView *cellImage;
    UILabel *creditCardLabel;
    UILabel *cardNumberLabel;
}

-(void) updateCell;

@end
