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

-(void)popToOrderViewController
{
    OrderViewController *popTo;
    for (UIViewController *viewController in [[self navigationController] viewControllers]) {
        if([viewController isKindOfClass:[OrderViewController class]])
            popTo = (id) viewController;
    }
    
    [[self navigationController]popToViewController:popTo animated:YES];
    
}

//Delegate functions
//***********************************************************

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    if ([indexPath row] < [[menuInfo submenuList] count]) {
        //Create the view controller, and push it
        
        id submenuThing;
        submenuThing = [[menuInfo submenuList] objectAtIndex:[indexPath row]];
        
        if([submenuThing isKindOfClass:[Item class]])
        {
            Item *newItem = [[Item alloc] initFromItem:submenuThing];
            [orderInfo addItem:newItem];
            [self popToOrderViewController];
        }
        else
        {
            MenuViewController *newController = [[MenuViewController alloc] initializeWithMenuAndOrder:submenuThing :orderInfo];
            
            [[self navigationController] pushViewController:newController animated:YES];
        }  
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
    menuView = [[MenuView alloc] init];
    [[menuView menuTable] setDelegate:self];
    [[menuView menuTable] setDataSource:menuRenderer];
    
    [[menuView cancelButton] setTarget:self];
    [[menuView cancelButton] setAction:@selector(popToOrderViewController)];
    
    [self setView:menuView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [menuRenderer redraw];
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
