//
//  ShinyOrderSummaryViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyOrderSummaryViewController.h"
#import "OrderSummaryPageRenderer.h"
#import "ShinyOrderSummaryView.h"

@implementation ShinyOrderSummaryViewController

- (id) initWithOrder:(Order *)anOrder
{
    self = [super init];
    if (self) 
    {
        theOrder = anOrder;
        renderer = [[OrderSummaryPageRenderer alloc] initWithOrder:theOrder];
        [theTableView setDataSource:renderer];
        [theTableView setBackgroundColor:[Utilities fravicLightPinkColor]];
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [(UILabel *)[[self navigationItem] titleView] setText:@"Order Summary"];
        
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonHit)];
    [backButton setTintColor:[Utilities fravicDarkRedColor]];
    
    [[self navigationItem] setLeftBarButtonItem:backButton];
    
    UIBarButtonItem *fillerButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:nil];
    [fillerButton setCustomView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 21)]];
    [[self navigationItem] setRightBarButtonItem:fillerButton];
}

-(void) backButtonHit
{
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
