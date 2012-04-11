//
//  SettingsTabViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsTabViewController.h"
#import "SettingsTabView.h"
#import "ShinySettingsTabRenderer.h"
#import "OrderHistoryViewController.h"

@implementation SettingsTabViewController

- (id) init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
        settingsTabView = [[SettingsTabView alloc] init];
        settingsTabRenderer = [[ShinySettingsTabRenderer alloc] init];
        [[settingsTabView settingsTable] setDelegate:self];
        [[settingsTabView settingsTable] setDataSource:settingsTabRenderer];
        
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
    
    [toolbarText setText:@"Settings"];
    [[self navigationItem] setTitleView:toolbarText];

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
    if ([[CustomViewCell cellIdentifierForData:[settingsTabRenderer objectForCellAtIndex:indexPath]] isEqualToString:@"ShinySettingsCell"])
    {
        NSString *theTitle = [[settingsTabRenderer objectForCellAtIndex:indexPath] objectForKey:@"settingTitle"];
        
        if ([theTitle isEqualToString:@"Credit Card"]) {
            //Dispatch the credit card page
        }
        
        if ([theTitle isEqualToString:@"Order History"]) {
            OrderHistoryViewController *newController = [[OrderHistoryViewController alloc] init];
            [[self navigationController] pushViewController:newController animated:YES];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CustomViewCell cellHeightForData:[settingsTabRenderer objectForCellAtIndex:indexPath]];
}

-(void)loadView
{
    [super loadView];
    [self setView:settingsTabView];
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
