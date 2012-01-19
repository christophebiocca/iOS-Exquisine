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
#import "UICustomActionSheet.h"

@interface UIActionSheet(AccessPrivate)
    @property(readonly)NSMutableArray* buttons;
@end

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

-(void)displayOptions
{
    UIActionSheet *test = [[UIActionSheet alloc] initWithTitle:@"whatev" delegate:self cancelButtonTitle:@"Canc" destructiveButtonTitle:@"Dest" otherButtonTitles:@"Blah", nil];
    
    //[test showInView:orderView];
    
    UICustomActionSheet *optionPopup = [[UICustomActionSheet alloc] initWithTitle:@"Do Stuff" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Submit this order!" otherButtonTitles:@"Add to favorites", nil];
    
    [optionPopup setBackgroundColor:[UIColor colorWithRed:72/255.0 green:78/255.0 blue:89/255.0 alpha:1.0]];
    
    [optionPopup setColor:[UIColor colorWithRed:36/255.0 green:99/255.0 blue:222/255.0 alpha:240/255.0] forButtonAtIndex:0];
    
    [optionPopup setColor:[UIColor colorWithRed:187/255.0 green:189/255.0 blue:192/255.0 alpha:240/255.0] forButtonAtIndex:1];
    [optionPopup setColor:[UIColor colorWithRed:30/255.0 green:38/255.0 blue:48/255.0 alpha:240/255.0] forButtonAtIndex:2];
    
    [optionPopup showInView:orderView];
    
}

//Delegate functions
//***********************************************************

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    if ([indexPath row] < [[orderInfo itemList] count]) {
        
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
    
    optionsButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(displayOptions)];
    
    [[self navigationItem] setRightBarButtonItems:[[NSArray alloc] initWithObjects:optionsButton, nil]];
    
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
