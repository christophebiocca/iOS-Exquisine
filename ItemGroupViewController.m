//
//  ItemGroupViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-01.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemGroupViewController.h"
#import "ItemGroup.h"
#import "ItemGroupRenderer.h"
#import "ItemGroupView.h"
#import "Item.h"
#import "Order.h"
#import "ItemViewController.h"


@implementation ItemGroupViewController

@synthesize itemGroupInfo;

-(ItemGroupViewController *)initWithItemGroupAndOrderAndReturnViewController:(ItemGroup *)anItemGroup :(Order *)anOrder :(UIViewController *)aViewController
{
    self = [super init];
    
    itemGroupInfo = anItemGroup;
    
    returnController = aViewController;
    
    currentOrder = anOrder;
    
    itemGroupRenderer = [[ItemGroupRenderer alloc] initFromItemGroup:anItemGroup];
    
    [[self navigationItem] setTitle:itemGroupInfo.name]; 
    
    return self;
}

//Delegate functions
//***********************************************************


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    id thingToPush = [[itemGroupInfo listOfItems] objectAtIndex:[indexPath row]];
    
    ItemViewController *newView = [[ItemViewController alloc] initializeWithItemAndOrderAndReturnController:thingToPush :currentOrder:returnController];
        
    [newView setDelegate:self];
    
    [[self navigationController] pushViewController:newView animated:YES];
    
}

-(void)tableView:(UITableView *) tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *) indexPath
{
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
}

-(void)addItemForController:(ItemViewController *)itemViewcontroller
{
    [itemGroupInfo setSatisfyingItem:[[itemViewcontroller itemInfo] copy]];
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
    itemGroupView = [[ItemGroupView alloc] init];
    [[itemGroupView itemGroupTable] setDelegate:self];
    [[itemGroupView itemGroupTable] setDataSource:itemGroupRenderer];
    
    [self setView:itemGroupView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[itemGroupView itemGroupTable] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
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
