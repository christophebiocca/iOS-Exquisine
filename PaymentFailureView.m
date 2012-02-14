//
//  PaymentInfoView.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentFailureView.h"

@implementation PaymentFailureView

@synthesize cancel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        bar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                                                               target:nil 
                                                               action:nil];
        [bar setItems:[NSArray arrayWithObjects:[[UIBarButtonItem alloc] 
                                                 initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                                 target:nil 
                                                 action:nil],
                       cancel, nil]];
        
        [self addSubview:bar];
        [self setBackgroundColor:[UIColor whiteColor]];
        error = [[UILabel alloc] initWithFrame:CGRectZero];
        [error setTextColor:[UIColor colorWithRed:0.7 green:0.3 blue:0.3 alpha:1]];
        [self addSubview:error];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#define TOOLBAR_HEIGHT 44
#define PADDING 5

-(void)layoutSubviews{
    CGSize lims = [self bounds].size;
    [bar setFrame:(CGRect){
        .size = {
            .width = lims.width,
            .height = TOOLBAR_HEIGHT
        }
    }];
    [error setFrame:(CGRect){
        .origin = {
            .x = PADDING,
            .y = TOOLBAR_HEIGHT + PADDING
        },
        .size = {
            .width = lims.width - 2*PADDING,
            .height = lims.height - TOOLBAR_HEIGHT - 2*PADDING
        }
    }];
}

-(void)setErrorMessage:(NSString *)message{
    [error setText:message];
}

@end
