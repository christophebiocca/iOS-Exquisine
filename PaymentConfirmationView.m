//
//  PaymentConfirmationView.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentConfirmationView.h"

@implementation PaymentConfirmationView

@synthesize change;

- (id)initWithCCDigits:(NSString *)ccDigits
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        notificationMessage = [[UILabel alloc] initWithFrame:CGRectZero];
        [notificationMessage setLineBreakMode:UILineBreakModeWordWrap];
        [notificationMessage setNumberOfLines:0];
        [self addSubview:notificationMessage];
        change = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [change setTitle:@"Click here to change your payment information." forState:UIControlStateNormal];
        [[change titleLabel] setLineBreakMode:UILineBreakModeWordWrap];
        [[change titleLabel] setAdjustsFontSizeToFitWidth:YES];
        [self addSubview:change];
        
        [self setCCDigits:ccDigits];
    }
    return self;
}

-(void)setCCDigits:(NSString *)ccDigits{
    [notificationMessage setText:[NSString stringWithFormat:@"We will charge your credit card ending in %@.", ccDigits]];
}

#define PADDING 12

-(void)layoutSubviews{
    CGSize lims = [self frame].size;
    
    CGRect notifFrame = (CGRect){
        .origin = {
            .x = PADDING,
            .y = PADDING
        },
        .size = [[notificationMessage text] sizeWithFont:[notificationMessage font] 
                                       constrainedToSize:(CGSize){.width=lims.width - 2*PADDING, .height=9999} 
                                           lineBreakMode:UILineBreakModeWordWrap]
    };
    
    [notificationMessage setFrame:notifFrame];
    
    [change setFrame:(CGRect){
        .origin = {
            .x = PADDING,
            .y = 2*PADDING + notifFrame.size.height
        },
        .size = {
            .width = lims.width - 2*PADDING,
            .height = 50
        }
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
