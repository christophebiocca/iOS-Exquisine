//
//  OrderSectionHeaderView.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderSectionHeaderView.h"

@implementation OrderSectionHeaderView

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 44)];
    if (self) {
        orderHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 26)];
        [orderHeaderLabel setBackgroundColor:[UIColor clearColor]];
        [orderHeaderLabel setTextColor:[Utilities fravicDarkRedColor]];
        [orderHeaderLabel setFont:[UIFont fontWithName:@"AmericanTypewriter-Bold" size:20]];
        [orderHeaderLabel setText:@"Current Order"];
        [self setBackgroundColor:[Utilities fravicLightPinkColor]];
        
        [self addSubview:orderHeaderLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [orderHeaderLabel setFrame:CGRectMake(10, ([self frame].size.height / 2) - [orderHeaderLabel frame].size.height/2 + 2, 200, [orderHeaderLabel frame].size.height)];
}
@end
