//
//  ItemViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemViewController.h"
#import "Item.h"
#import "Order.h"
#import "ItemRenderer.h"
#import "OptionViewController.h"
#import "ItemView.h"

@implementation ItemViewController

@synthesize itemInfo;

-(ItemViewController *)initializeWithItemAndOrder:(Item *) anItem :(Order *) anOrder
{
    
    itemInfo = anItem;
    ownerOrder = anOrder;
    
    itemRenderer = [[ItemRenderer alloc] initWithItem:anItem];
    [[self navigationItem] setTitle:anItem.name];
    
    return self;
}

-(void)deleteButtonPressed
{
    [[ownerOrder itemList] removeObject:itemInfo];
    [[self navigationController] popViewControllerAnimated:YES];
}

//Delegate functions
//***********************************************************

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    if ([indexPath row] < [[itemInfo options] count]) {
        OptionViewController *newOptionViewController = [[OptionViewController alloc] initializeWithOption:[[itemInfo options] objectAtIndex:[indexPath row]]];
        
        [[self navigationController] pushViewController:newOptionViewController animated:YES];
        
        //Make and push the option view controller
    }
    
    //i.e. if the "Add Item" row was selected
    if([indexPath row] == [[itemInfo options] count] + 2){
        //Push item selection page
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
    itemView = [[ItemView alloc] init];
    [[itemView itemTable] setDelegate:self];
    [[itemView itemTable] setDataSource:itemRenderer];
    
    [[itemView deleteButton] setTarget:self];
    [[itemView deleteButton] setAction:@selector(deleteButtonPressed)];
    
    [self setView:itemView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [itemRenderer redraw];
    [[itemView itemTable] reloadData];
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
