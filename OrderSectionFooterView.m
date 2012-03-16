//
//  OrderSectionFooterView.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderSectionFooterView.h"

@implementation OrderSectionFooterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        footerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SubOrderOptionSelectorBar.png"]];
        [self setFrame:[footerImage frame]];
        [self addSubview:footerImage];
        
        placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(101, 27, 60, 30)];
        
        editLabel = [[UILabel alloc] initWithFrame:CGRectMake(173, 27, 60, 30)];
        
        [placeLabel setFont:[UIFont fontWithName:@"AmericanTypewriter" size:20]];
        [placeLabel setTextColor:[UIColor blackColor]];
        [placeLabel setBackgroundColor:[UIColor clearColor]];
        [placeLabel setText:@"Place"];
        [editLabel setFont:[UIFont fontWithName:@"AmericanTypewriter" size:20]];
        [editLabel setTextColor:[UIColor blackColor]];
        [editLabel setBackgroundColor:[UIColor clearColor]];
        [editLabel setText:@"Edit"];
        
        [self addSubview:editLabel];
        [self addSubview:placeLabel];
    }
    return self;
}

@end
