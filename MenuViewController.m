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

@implementation MenuViewController

@synthesize menuInfo;

-(MenuViewController *)initializeWithMenuAndOrder:(Menu *) aMenu:(Order *) anOrder
{
    
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
    
    id submenuThing;
    
    submenuThing = [[menuInfo submenuList] objectAtIndex:[indexPath row]];
        
    if([submenuThing isKindOfClass:[Item class]])
    {
        
        Item *newItem = [[Item alloc] initFromItem:submenuThing];
        
        ItemViewController *newView = [[ItemViewController alloc] initializeWithItemAndOrder:newItem :orderInfo];
        
        [[self navigationController] pushViewController:newView animated:YES];
    }
    if([submenuThing isKindOfClass:[Menu class]])
    {
        
        MenuViewController *newController = [[MenuViewController alloc] initializeWithMenuAndOrder:submenuThing :orderInfo];
            
        [[self navigationController] pushViewController:newController animated:YES];
        
    }
}

-(void)tableView:(UITableView *) tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *) indexPath
{
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
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
    [[menuView menuTable] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
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
