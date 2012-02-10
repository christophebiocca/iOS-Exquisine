//
//  PaymentCompletedView.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentCompletedView.h"

@implementation PaymentCompletedView

@synthesize done;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
        
        bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
        done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:nil];
        UIBarButtonItem* space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [bar setItems:[NSArray arrayWithObjects:space, done, nil]];
        [self addSubview:bar];
        
        message = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 0, 0)];
        [message setLineBreakMode:UILineBreakModeWordWrap];
        [message setNumberOfLines:0];
        [message setText:@"Success"];
        [self addSubview:message];
    }
    return self;
}

#define TOOLBAR_HEIGHT 44
#define PADDING 10

-(void)layoutSubviews{
    CGSize lims = [self frame].size;
    [bar setFrame:(CGRect){
        .size = {
            .width = lims.width,
            .height = TOOLBAR_HEIGHT
        }
    }];
    [message setFrame:(CGRect){
        .origin = {
            .x = PADDING,
            .y = TOOLBAR_HEIGHT + PADDING
        },
        .size = {
            .width = lims.width - 2*PADDING,
            .height = lims.height - 2*PADDING - TOOLBAR_HEIGHT
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

-(void)setSuccessInfo:(PaymentSuccessInfo*)info{
    
}

@end
