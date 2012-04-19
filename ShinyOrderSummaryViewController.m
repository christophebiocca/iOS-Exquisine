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
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        theOrder = anOrder;
        orderSummaryView = [[ShinyOrderSummaryView alloc] init];
        orderSummaryRenderer = [[OrderSummaryPageRenderer alloc] initWithOrder:theOrder];
        [[orderSummaryView orderSummaryTable] setDelegate:self];
        [[orderSummaryView orderSummaryTable] setDataSource:orderSummaryRenderer];
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{

    [[[self navigationController] navigationBar] setBackgroundImage:[UIImage imageNamed:@"BlankTopbarWithShadow.png"] forBarMetrics:UIBarMetricsDefault];
    
    UILabel *toolbarText = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                     ([[[self navigationController] navigationBar] frame ].size.width - 300) / 2,
                                                                     (44 - 30) / 2, 
                                                                     300, 
                                                                     30)];
    [toolbarText setFont:[UIFont fontWithName:@"Optima-ExtraBlack" size:22]];
    [toolbarText setTextColor:[UIColor whiteColor]];
    [toolbarText setBackgroundColor:[UIColor clearColor]];
    [toolbarText setTextAlignment:UITextAlignmentCenter];
    
    [toolbarText setText:@"Order Summary"];
    [[self navigationItem] setTitleView:toolbarText];
    
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CustomViewCell cellHeightForData:[orderSummaryRenderer objectForCellAtIndex:indexPath]];
}

-(void)loadView
{
    [super loadView];
    [self setView:orderSummaryView];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
