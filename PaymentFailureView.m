//
//  PaymentInfoView.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentFailureView.h"

@implementation PaymentFailureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        error = [[UILabel alloc] initWithFrame:CGRectZero];
        [error setTextColor:[UIColor colorWithRed:0.7 green:0.3 blue:0.3 alpha:1]];
        [error setLineBreakMode:UILineBreakModeWordWrap];
        [error setNumberOfLines:0];
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

#define PADDING 5

-(void)layoutSubviews{
    CGSize lims = [self bounds].size;
    CGSize limitSize = {
        .width = lims.width - 2*PADDING,
        .height = lims.height - 2*PADDING
    };
    limitSize = [[error text] sizeWithFont:[error font] 
                         constrainedToSize:limitSize 
                             lineBreakMode:UILineBreakModeWordWrap];
    [error setFrame:(CGRect){
        .origin = {
            .x = PADDING,
            .y = PADDING
        },
        .size = limitSize
    }];
}

-(void)setErrorMessage:(NSString *)message{
    [error setText:message];
    [self setNeedsLayout];
}

@end
