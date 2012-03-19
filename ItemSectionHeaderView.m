//
//  ItemSectionHeaderView.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemSectionHeaderView.h"

@implementation ItemSectionHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        headerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ListHeader.png"]];
        [self setFrame:[headerImage frame]];
        itemLabel = [[UILabel alloc] init];
        [itemLabel setText:@"Options"];
        [itemLabel setFrame:CGRectMake(46, 28, 196, 21)];
        [itemLabel setFont:[Utilities fravicHeadingFont]];
        [itemLabel setTextAlignment:UITextAlignmentLeft];
        [itemLabel setTextColor:[Utilities fravicDarkRedColor]];
        [itemLabel setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:itemLabel];
        [self addSubview:headerImage];
        [self sendSubviewToBack:headerImage];
        
    }
    return self;
}

@end
