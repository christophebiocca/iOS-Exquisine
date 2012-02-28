//
//  MenuViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import "OrderViewController.h"
#import "MenuRenderer.h"
#import "Item.h"
#import "Order.h"
#import "Menu.h"
#import "MenuView.h"
#import "ItemViewController.h"
#import "Combo.h"
#import "ComboViewController.h"

@implementation MenuViewController

@synthesize menuInfo;

-(MenuViewController *)initializeWithMenuAndOrderAndOrderViewController:(Menu *)aMenu :(Order *)anOrder :(OrderViewController *)anOrderViewController
{
    orderViewController = anOrderViewController;
    orderInfo = anOrder;
    menuInfo = aMenu;
    menuRenderer = [[MenuRenderer alloc] initWithMenu:menuInfo];
    [[self navigationItem] setTitle:menuInfo.name];
    
    return self;
}

//Delegate functions
//***********************************************************


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    NSMutableArray *displayList = [[NSMutableArray alloc] initWithArray:[menuInfo submenuList]];
    
    [displayList addObjectsFromArray:[menuInfo comboList]];
    
    id submenuThing = [displayList objectAtIndex:[indexPath row]];
        
    if([submenuThing isKindOfClass:[Item class]])
    {
        
        Item *newItem = [submenuThing copy];
        
        ItemViewController *newView = [[ItemViewController alloc] initializeWithItemAndOrderAndReturnController:newItem :orderInfo :orderViewController];
        
        [newView setDelegate:self];
        
        [[self navigationController] pushViewController:newView animated:YES];
    }
    if([submenuThing isKindOfClass:[Menu class]])
    {
        
        MenuViewController *newController = [[MenuViewController alloc] initializeWithMenuAndOrderAndOrderViewController:submenuThing :orderInfo :orderViewController];
        
        [[self navigationController] pushViewController:newController animated:YES];
        
    }
    
    if([submenuThing isKindOfClass:[Combo class]])
    {
        
        ComboViewController *newController = [[ComboViewController alloc] initializeWithComboAndOrderAndReturnController:[submenuThing copy]:orderInfo:orderViewController];
        
        [[self navigationController] pushViewController:newController animated:YES];
        
    }
}

-(void)tableView:(UITableView *) tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *) indexPath
{
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
}

-(void)addItemForController:(ItemViewController *)itemViewcontroller
{
    [orderInfo addItem:[[itemViewcontroller itemInfo] copy]];
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
    menuView = [[MenuView alloc] init];
    [[menuView menuTable] setDelegate:self];
    [[menuView menuTable] setDataSource:menuRenderer];
    
    [self setView:menuView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Entered a submenu"];
    [[menuView menuTable] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
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
