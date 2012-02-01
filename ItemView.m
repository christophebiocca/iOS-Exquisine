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
@synthesize priceButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        itemTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        itemToolBar = [[UIToolbar alloc] init];
        
        UIBarButtonItem *spacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *spacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        priceButton = [[UIBarButtonItem alloc] initWithTitle:@"Item price:" style:UIBarButtonItemStylePlain target:self action:nil];
        
        [itemToolBar setItems:[NSArray arrayWithObjects:spacer1, priceButton,spacer2,nil]];
        
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
