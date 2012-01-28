//
//  MenuView.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

@synthesize menuTable;
@synthesize menuToolBar;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        menuTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        menuToolBar = [[UIToolbar alloc] init];
        
        [self addSubview:menuTable];
        [self addSubview:menuToolBar];
    }
    return self;
}

-(void)layoutSubviews
{
    [menuTable setFrame:CGRectMake(0, 0, 320, 372)];
    [menuToolBar setFrame:CGRectMake(0, 372, 320, 44)];
}


@end
