//
//  ItemGroupSectionHeaderView.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemGroupSectionHeaderView.h"

@implementation ItemGroupSectionHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        headerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ListHeader.png"]];
        [self setFrame:[headerImage frame]];
        headerLabel = [[UILabel alloc] init];
        [headerLabel setText:@"Combo Components"];
        [headerLabel setFrame:CGRectMake(46, 28, 196, 21)];
        [headerLabel setFont:[Utilities fravicHeadingFont]];
        [headerLabel setTextAlignment:UITextAlignmentLeft];
        [headerLabel setTextColor:[Utilities fravicDarkRedColor]];
        [headerLabel setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:headerLabel];
        [self addSubview:headerImage];
        [self sendSubviewToBack:headerImage];
        
    }
    return self;
}

@end
