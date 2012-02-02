//
//  ItemGroupView.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-01.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemGroupView.h"

@implementation ItemGroupView

@synthesize itemGroupTable;
@synthesize itemGroupToolBar;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        itemGroupTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        itemGroupToolBar = [[UIToolbar alloc] init];
        
        [self addSubview:itemGroupTable];
        [self addSubview:itemGroupToolBar];
    }
    return self;
}

-(void)layoutSubviews
{
    [itemGroupTable setFrame:CGRectMake(0, 0, 320, 372)];
    [itemGroupToolBar setFrame:CGRectMake(0, 372, 320, 44)];
}

@end
