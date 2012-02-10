//
//  PaymentConfirmationView.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentConfirmationView.h"

@implementation PaymentConfirmationView

@synthesize confirm, change, cancel;

- (id)initWithCCDigits:(NSString *)ccDigits
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        confirm = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:nil];
        [confirm setTitle:@"Confirm"];
        cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:nil action:nil];
        bar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        [bar setItems:[NSArray arrayWithObjects:cancel, 
                       [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                                                     target:nil action:nil],
                       confirm, nil]];
        [self addSubview:bar];
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
#define TOOLBAR_HEIGHT 44

-(void)layoutSubviews{
    CGSize lims = [self frame].size;
    [bar setFrame:(CGRect){
        .size = {
            .width = lims.width,
            .height = TOOLBAR_HEIGHT
        }
    }];
    
    CGRect notifFrame = (CGRect){
        .origin = {
            .x = PADDING,
            .y = TOOLBAR_HEIGHT + PADDING
        },
        .size = [[notificationMessage text] sizeWithFont:[notificationMessage font] 
                                       constrainedToSize:(CGSize){.width=lims.width - 2*PADDING, .height=9999} 
                                           lineBreakMode:UILineBreakModeWordWrap]
    };
    
    [notificationMessage setFrame:notifFrame];
    
    [change setFrame:(CGRect){
        .origin = {
            .x = PADDING,
            .y = TOOLBAR_HEIGHT + 2*PADDING + notifFrame.size.height
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
