//
//  OrderHistoryViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderHistoryViewController.h"
#import "OrderHistoryRenderer.h"
#import "OrderHistoryView.h"
#import "AppData.h"

@implementation OrderHistoryViewController

- (id) init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
        orderHistoryView = [[OrderHistoryView alloc] init];
        orderHistoryRenderer = [[OrderHistoryRenderer alloc] init];
        [[orderHistoryView orderHistoryTable] setDelegate:self];
        [[orderHistoryView orderHistoryTable] setDataSource:orderHistoryRenderer];
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [[AppData appData] updateOrderHistory];
    
    orderHistoryRenderer = [[OrderHistoryRenderer alloc] init];
    [[orderHistoryView orderHistoryTable] setDelegate:self];
    [[orderHistoryView orderHistoryTable] setDataSource:orderHistoryRenderer];
    
    [[orderHistoryView orderHistoryTable] reloadData];
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
    
    [toolbarText setText:@"Order History"];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Dispatch an order summary page
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CustomViewCell cellHeightForData:[orderHistoryRenderer objectForCellAtIndex:indexPath]];
}

-(void)loadView
{
    [super loadView];
    [self setView:orderHistoryView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
