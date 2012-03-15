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
        
        placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(102, 7, 60, 30)];
        
        orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 7, 60, 30)];
        
        [placeLabel setFont:[Utilities fravicHeadingFont]];
        [placeLabel setTextColor:[Utilities fravicDarkRedColor]];
        [placeLabel setBackgroundColor:[UIColor clearColor]];
        [placeLabel setText:@"Place"];
        [orderLabel setFont:[Utilities fravicHeadingFont]];
        [orderLabel setTextColor:[Utilities fravicDarkRedColor]];
        [orderLabel setBackgroundColor:[UIColor clearColor]];
        [orderLabel setText:@"Order"];
        
        [self addSubview:orderLabel];
        [self addSubview:placeLabel];
    }
    return self;
}

@end
