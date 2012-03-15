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
