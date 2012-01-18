//
//  OrderViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderViewController.h"
#import "ItemViewController.h"
#import "Item.h"
#import "Menu.h"
#import "MenuViewController.h"
#import "Order.h"
#import "OrderView.h"
#import "OrderRenderer.h"

@implementation OrderViewController

@synthesize orderInfo;

-(OrderViewController *)initializeWithMenuAndOrder:(Menu *) aMenu:(Order *) anOrder
{
    menuInfo = aMenu;
    orderInfo = anOrder;
    orderRenderer = [[OrderRenderer alloc] initWithOrder:anOrder];
    [[self navigationItem] setTitle:anOrder.name];
    
    return self;
}

//Delegate functions
//***********************************************************

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    if ([indexPath row] < [[orderInfo itemList] count]) {
        //Create the view controller, and push it
        ItemViewController *itemViewController = [[ItemViewController alloc] initializeWithItemAndOrder:[[orderInfo itemList] objectAtIndex:[indexPath row]]:orderInfo];
        [[self navigationController] pushViewController:itemViewController animated:YES];
        
    }
    
    //i.e. if the "Add Item" row was selected
    if([indexPath row] == ([[orderInfo itemList] count] + 1)){
        //allocate a new menu renderer passing this order to it     
        MenuViewController *menuViewController = [[MenuViewController alloc] initializeWithMenuAndOrder:menuInfo :orderInfo];
        
        //Push the menu page
        [[self navigationController] pushViewController:menuViewController animated:YES];
    }
    
}

//View related functions
//***********************************************************

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) loadView
{
    orderView = [[OrderView alloc] init];
    [[orderView orderTable] setDelegate:self];
    [[orderView orderTable] setDataSource:orderRenderer];
    [self setView:orderView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [orderRenderer redraw];
    [[orderView orderTable] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
