//
//  PaymentProcessingView.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentProcessingView.h"

@implementation PaymentProcessingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor blackColor]];
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [indicator startAnimating];
        [self addSubview:indicator];
        
        processingText = [[UILabel alloc] initWithFrame:CGRectZero];
        [processingText setBackgroundColor:[UIColor blackColor]];
        [processingText setTextColor:[UIColor lightGrayColor]];
        [processingText setText:@"Processing your order"];
        [processingText setFont:[Utilities fravicHeadingFont]];
        [processingText setLineBreakMode:UILineBreakModeWordWrap];
        [processingText setNumberOfLines:0];
        [processingText setTextAlignment:UITextAlignmentCenter];
        [self addSubview:processingText];
    }
    return self;
}

#define PADDING 5

-(void)layoutSubviews{
    CGSize lims = [self bounds].size;
    
    CGSize indicatorSize = [indicator frame].size;
    [indicator setFrame:(CGRect){
        .origin = {
            .x = (NSInteger)((lims.width - indicatorSize.width)/2),
            .y = (NSInteger)((lims.height - indicatorSize.height)/2)
        },
        .size  = indicatorSize
    }];
    
    [processingText setFrame:(CGRect){
        .origin = {
            .x = PADDING,
            .y = PADDING
        },
        .size = {
            .width = lims.width - 2 * PADDING,
            .height = (lims.height - indicatorSize.height)/2 - 2*PADDING
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
