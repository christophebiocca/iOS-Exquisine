//
//  ItemView.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemView.h"

@implementation ItemView

@synthesize itemTable;
@synthesize itemToolBar;
@synthesize totalLabelValue;
@synthesize totalLabelHeading;
@synthesize deleteButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        itemTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        itemToolBar = [[UIToolbar alloc] init];
        
        deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"Remove This Item" style:UIBarButtonItemStyleDone target:self action:sel_registerName("deleteButton")];
        
        [deleteButton setWidth:308];
        [deleteButton setTintColor:[UIColor colorWithRed:235/255.0 green:12/255.0 blue:20/255.0 alpha:230/255.0]];
        
        NSArray *toolbarItems = [NSArray arrayWithObjects: deleteButton, nil];
        [itemToolBar setItems:toolbarItems animated:NO];
        
        [self addSubview:itemToolBar];
        [self addSubview:itemTable];
    }
    return self;
}

-(void)layoutSubviews
{
    [itemTable setFrame:CGRectMake(0, 0, 320, 372)];
    [itemToolBar setFrame:CGRectMake(0, 372, 320, 44)];
}


@end
