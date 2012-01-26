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
#import "Option.h"
#import "OptionViewController.h"
#import "Menu.h"
#import "MenuView.h"
#import "TunnelViewController.h"
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

-(void)enterItemTunnel:(Item *) anItem
{
    selectedItem = anItem;
    
    NSMutableArray *manditoryOptions = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (Option *currentOption in [anItem options]) {
        //i.e. if the option is manditory
        if ([currentOption lowerBound] > 0) {
                
            //Set up the tunnel version of the option view controllers here.
            OptionViewController *optionController = [[OptionViewController alloc] initializeWithOption:currentOption];
            
            [manditoryOptions addObject:optionController];
        }
    }
    
    if([manditoryOptions count] > 0)
    {
        itemCustomizationTunnel = [[TunnelViewController alloc] initWithTunnelList:manditoryOptions];
    
        [itemCustomizationTunnel setTunnelDelegate:self];
        
        [self presentModalViewController:[itemCustomizationTunnel navController] animated:YES]; 
    }
    else
    {
        [self lastControllerBeingPushedPast:itemCustomizationTunnel];
    }
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


-(void) firstControllerBeingPopped:(TunnelViewController *) tunnelController
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void) lastControllerBeingPushedPast:(TunnelViewController *) tunnelController
{
    [orderInfo addItem:selectedItem];
    
    ItemViewController *itemViewController = [[ItemViewController alloc] initializeWithItemAndOrder:selectedItem :orderInfo];  
    
    NSMutableArray *newStack = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (UIViewController *aController in [[self navigationController] viewControllers]) {
        [newStack addObject:aController];
        if ([aController isKindOfClass:[OrderViewController class]]) {
            break;
        }
    }
    
    NSInteger manditoryCount = 0;
    for (Option *currentOption in [selectedItem options]) {
        //i.e. if the option is manditory
        if ([currentOption lowerBound] > 0) {
            manditoryCount++;
        }
    }
    if (([[selectedItem options] count] - manditoryCount) > 0) {
        [newStack addObject:itemViewController];
    }
    
    [self dismissModalViewControllerAnimated:YES];
    
    [[self navigationController] setViewControllers:newStack animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    if ([indexPath row] < [[menuInfo submenuList] count]) {
        //Create the view controller, and push it
        
        id submenuThing;
        submenuThing = [[menuInfo submenuList] objectAtIndex:[indexPath row]];
        
        if([submenuThing isKindOfClass:[Item class]])
        {
            //Now that we know that we need to be customizing an Item, we need to figure
            //out what tunnel we should be defining such that the end of the tunnel will
            //lead to a configured item.
            
            //i.e. we need to build a tunnel that forces the user to define all of the
            //manditory options associated with the item.
            
            Item *newItem = [[Item alloc] initFromItem:submenuThing];
            
            [self enterItemTunnel:newItem];
        }
        else
        {
            MenuViewController *newController = [[MenuViewController alloc] initializeWithMenuAndOrder:submenuThing :orderInfo];
            
            [[self navigationController] pushViewController:newController animated:YES];
        }  
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
