//
//  ShinyHeaderView.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyHeaderView.h"

@implementation ShinyHeaderView

- (id)initWithTitle:(NSString *) title
{
    self = [super initWithFrame:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ListHeader.png"]] frame]];
    if (self) {
        menuHeaderImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ListHeader.png"]];
        [self setFrame:[menuHeaderImage frame]];
        menuLabel = [[UILabel alloc] init];
        [menuLabel setText:title];
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

@end
