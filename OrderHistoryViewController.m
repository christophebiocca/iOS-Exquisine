//
//  OrderHistoryViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderHistoryViewController.h"
#import "ShinyOrderSummaryViewController.h"
#import "OrderHistoryRenderer.h"
#import "AppData.h"

@implementation OrderHistoryViewController

- (id) init
{
    self = [super init];
    if (self) 
    {
        renderer = [[OrderHistoryRenderer alloc] init];
        [theTableView setDataSource:renderer];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[AppData appData] updateOrderHistory];
    
    renderer = [[OrderHistoryRenderer alloc] init];
    [theTableView setDataSource:renderer];
    [theTableView reloadData];
    
    [(UILabel *)[[self navigationItem] titleView] setText:@"Order History"];
    
        UIBarButtonItem *fillerButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:nil];
    [fillerButton setCustomView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 21)]];
    [[self navigationItem] setRightBarButtonItem:fillerButton];
}

@end
