//
//  PaymentCompletedView.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentCompletedView.h"
#import "PaymentSuccessInfo.h"
#import "Order.h"

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
        
        authCode = [[UILabel alloc] init];
        messageText = [[UILabel alloc] init];
        trnAmount = [[UILabel alloc] init];
        trnDate = [[UILabel alloc] init];
        pickupTime = [[UILabel alloc] init];
        signoff = [[UILabel alloc] init];
        
        UIFont *theFont = [UIFont fontWithName:@"Helvetica" size:16];
        
        [authCode setFont:theFont];
        [messageText setFont:theFont];
        [trnAmount setFont:theFont];
        [trnDate setFont:theFont];
        [pickupTime setFont:theFont];
        [signoff setFont:theFont];
        
        [self addSubview:authCode];
        [self addSubview:messageText];
        [self addSubview:trnAmount];
        [self addSubview:trnDate];
        [self addSubview:pickupTime];
        [self addSubview:signoff];
    }
    return self;
}

#define TOOLBAR_HEIGHT 44
#define PADDING 6
#define LABELHEIGHT 30

-(void)layoutSubviews{
    CGSize lims = [self frame].size;
    [bar setFrame:(CGRect){
        .size = {
            .width = lims.width,
            .height = TOOLBAR_HEIGHT
        }
    }];
    [messageText setFrame:(CGRect){
        .origin = {
            .x = PADDING,
            .y = TOOLBAR_HEIGHT + PADDING + (PADDING + LABELHEIGHT) * 0
        },
        .size = {
            .width = lims.width - 2*PADDING,
            .height = LABELHEIGHT
        }
    }];
    [authCode setFrame:(CGRect){
        .origin = {
            .x = PADDING,
            .y = TOOLBAR_HEIGHT + PADDING + (PADDING + LABELHEIGHT) * 1
        },
        .size = {
            .width = lims.width - 2*PADDING,
            .height = LABELHEIGHT
        }
    }];
    [trnAmount setFrame:(CGRect){
        .origin = {
            .x = PADDING,
            .y = TOOLBAR_HEIGHT + PADDING + (PADDING + LABELHEIGHT) * 2
        },
        .size = {
            .width = lims.width - 2*PADDING,
            .height = LABELHEIGHT
        }
    }];
    [trnDate setFrame:(CGRect){
        .origin = {
            .x = PADDING,
            .y = TOOLBAR_HEIGHT + PADDING + (PADDING + LABELHEIGHT) * 3
        },
        .size = {
            .width = lims.width - 2*PADDING,
            .height = LABELHEIGHT
        }
    }];
    [pickupTime setFrame:(CGRect){
        .origin = {
            .x = PADDING,
            .y = TOOLBAR_HEIGHT + PADDING + (PADDING + LABELHEIGHT) * 5
        },
        .size = {
            .width = lims.width - 2*PADDING,
            .height = LABELHEIGHT
        }
    }];
    [signoff setFrame:(CGRect){
        .origin = {
            .x = PADDING,
            .y = TOOLBAR_HEIGHT + PADDING + (PADDING + LABELHEIGHT) * 6
        },
        .size = {
            .width = lims.width - 2*PADDING,
            .height = LABELHEIGHT
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

-(void)setSuccessInfo:(PaymentSuccessInfo*)info AndOrderInfo:(Order *) theOrder{
    
    [messageText setText: [NSString stringWithFormat:@"Transaction result: %@", [info messageText]]];
    [authCode setText: [NSString stringWithFormat:@"Authorization code: %@", [info authCode]]];
    [trnAmount setText: [NSString stringWithFormat:@"Total: $%@", [info trnAmount]]];
    [trnDate setText: [NSString stringWithFormat:@"Date: %@", [info trnDate]]];
    
    NSDateFormatter* formatter = [NSDateFormatter new];
    
    [formatter setDateFormat:@"h:mm a"];
    
    [pickupTime setText: [NSString stringWithFormat:@"Your pita will be done at %@", [formatter stringFromDate:[theOrder pitaFinishedTime]]]];
    
    [signoff setText:@"Enjoy!"];
    
}

@end
