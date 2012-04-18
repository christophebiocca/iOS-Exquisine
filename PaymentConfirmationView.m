//
//  PaymentConfirmationView.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentConfirmationView.h"

@implementation PaymentConfirmationView

@synthesize accept, change;

+(UIButton*)buttonWithTitle:(NSString*)title{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"ItemGroupSatisfied"] forState:UIControlStateNormal];
    [[button titleLabel] setLineBreakMode:UILineBreakModeWordWrap];
    [[button titleLabel] setAdjustsFontSizeToFitWidth:YES];
    [[button titleLabel] setFont:[Utilities fravicHeadingFont]];
    [button setTitle:title forState:UIControlStateNormal];
    CGSize titleSize = [title sizeWithFont:[[button titleLabel] font]];
    CGSize spaceSize = {
        .width = 125,
        .height = 31
    };
    CGFloat vOffset = (spaceSize.height - titleSize.height)/2;
    CGFloat hOffset = (spaceSize.width - titleSize.width)/2;
    [button setTitleEdgeInsets:(UIEdgeInsets){
        .top = 14 + vOffset,
        .left = 90 + hOffset,
        .right = 105 + hOffset,
        .bottom = 3 + vOffset
    }];
    [button setTitleColor:[Utilities fravicDarkRedColor] forState:UIControlStateNormal];
    
    [button setAdjustsImageWhenHighlighted:NO];
    
    return button;
}

- (id)initWithCCDigits:(NSString *)ccDigits
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        notificationMessage = [[UILabel alloc] initWithFrame:CGRectZero];
        [notificationMessage setLineBreakMode:UILineBreakModeWordWrap];
        [notificationMessage setNumberOfLines:0];
        [notificationMessage setFont:[Utilities fravicHeadingFont]];
        [self addSubview:notificationMessage];
        accept = [PaymentConfirmationView buttonWithTitle:@"Use this card"];
        [self addSubview:accept];
        change = [PaymentConfirmationView buttonWithTitle:@"Change card"];
        [self addSubview:change];
        
        [self setCCDigits:ccDigits];
    }
    return self;
}

-(void)setCCDigits:(NSString *)ccDigits{
    [notificationMessage setText:[NSString stringWithFormat:@"Credit card: ************%@.", ccDigits]];
}

#define PADDING 18
#define BUTTON_HEIGHT 58

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
    
    [accept setFrame:(CGRect){
        .origin = {
            .x = 0,
            .y = 2*PADDING + notifFrame.size.height
        },
        .size = {
            .width = lims.width,
            .height = BUTTON_HEIGHT
        }
    }];
    
    [change setFrame:(CGRect){
        .origin = {
            .x = 0,
            .y = 3*PADDING + notifFrame.size.height + BUTTON_HEIGHT
        },
        .size = {
            .width = lims.width,
            .height = BUTTON_HEIGHT
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
