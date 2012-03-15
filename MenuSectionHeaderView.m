//
//  MenuSectionHeaderView.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuSectionHeaderView.h"
#import "Utilities.h"

@implementation MenuSectionHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        menuHeaderImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ListHeader.png"]];
        [self setFrame:[menuHeaderImage frame]];
        menuLabel = [[UILabel alloc] init];
        [menuLabel setText:@"Menu"];
        [menuLabel setFrame:CGRectMake(46, 28, 196, 21)];
        [menuLabel setFont:[Utilities fravicHeadingFont]];
        [menuLabel setTextAlignment:UITextAlignmentLeft];
        [menuLabel setTextColor:[Utilities fravicDarkRedColor]];
        [menuLabel setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:menuLabel];
        [self addSubview:menuHeaderImage];
        [self sendSubviewToBack:menuHeaderImage];
        
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

@end
