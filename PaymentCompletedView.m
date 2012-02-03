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
        
        UIToolbar* toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
        done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:nil];
        UIBarButtonItem* space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [toolbar setItems:[NSArray arrayWithObjects:space, done, nil]];
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 0, 0)];
        [self addSubview:label];
        [label setText:@"Success"];
        [label sizeToFit];
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

-(void)setSuccessInfo:(PaymentSuccessInfo*)info{
    
}

@end
