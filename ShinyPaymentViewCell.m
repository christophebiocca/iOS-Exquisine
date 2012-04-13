//
//  ShinyPaymenyViewCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyPaymentViewCell.h"
#import "PaymentProfileInfo.h"

@implementation ShinyPaymentViewCell

-(id)init
{
    self = [super init];
    
    if (self) {
        cellImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PaymentViewCell.png"]];
        
        [self addSubview:cellImage];
        
        creditCardLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 17, 250, 21)];
        [creditCardLabel setFont:[Utilities fravicHeadingFont]];
        [creditCardLabel setTextAlignment:UITextAlignmentCenter];
        [creditCardLabel setTextColor:[UIColor blackColor]];
        [creditCardLabel setBackgroundColor:[UIColor clearColor]];
        [creditCardLabel setAdjustsFontSizeToFitWidth:YES];
        
        cardNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 33, 250, 21)];
        [cardNumberLabel setFont:[Utilities fravicHeadingFont]];
        [cardNumberLabel setTextAlignment:UITextAlignmentCenter];
        [cardNumberLabel setTextColor:[UIColor blackColor]];
        [cardNumberLabel setBackgroundColor:[UIColor clearColor]];
        [cardNumberLabel setAdjustsFontSizeToFitWidth:YES];
        
        [self addSubview:cellImage];
        [self addSubview:cardNumberLabel];
        [self addSubview:creditCardLabel];
    }
    
    return self;
}

+(BOOL) canDisplayData:(id)data
{
    //Returns true iff the data passed in is meant to be displayed by this cell.
    return ([data isKindOfClass:[PaymentProfileInfo class]]);
}

+(NSString *) cellIdentifier
{
    //Must return a unique string identifier for this type of cell.
    return @"ShinyPaymentViewCell";
}

-(void) setData:(id) data
{
    if (![[self class] canDisplayData:data])
    {
        CLLog(LOG_LEVEL_ERROR, @"An unsupported data type was sent to ShinyPaymentViewCell's setData:");
        return;
    }
    
    paymentInfo = data;
    
    [self updateCell];
}

+(CGFloat)cellHeightForData:(id)data
{
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PaymentViewCell.png"]] frame].size.height;
}

-(void) updateCell
{
    [creditCardLabel setText:@"Credit Card"];
    [cardNumberLabel setText:[NSString stringWithFormat:@"Card Number: **** **** **** %@", [paymentInfo last4Digits]]];
    //Any of the changed associated with the data input in setData should occur here.
    //If the data is prone to changing, this cell should call updateCell via an NSNotificationCenter.
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

@end
