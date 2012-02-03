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
#import "OrderViewController.h"
#import "ItemView.h"
#import "Choice.h"
#import "Option.h"
#import "Utilities.h"

@implementation ItemViewController

@synthesize itemInfo;

-(ItemViewController *)initializeWithItemAndOrderAndReturnController:(Item *) anItem:(Order *)anOrder:(UIViewController *) aController
{
    
    returnController = aController;
    itemInfo = anItem;
    ownerOrder = anOrder;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemAltered) name:ITEM_MODIFIED object:anItem];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Add to order" style:UIBarButtonItemStyleDone target:self action:@selector(addThisItemToOrder)];
    
    if (![[anOrder itemList] containsObject:anItem]) {
        [[self navigationItem] setRightBarButtonItem:doneButton];
    }
    
    itemRenderer = [[ItemRenderer alloc] initWithItem:anItem];
    [[self navigationItem] setTitle:anItem.name];
    
    return self;
}

-(void)addThisItemToOrder
{
    
    [ownerOrder addItem:[[Item alloc] initFromItem:itemInfo]];

    [[self navigationController] popToViewController:returnController animated:YES];
    
}

//Delegate functions
//***********************************************************

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    if (!([indexPath section] == [[itemInfo options] count]))
    {
        
        Option *thisOption = [[itemInfo options] objectAtIndex:[indexPath section]];
        Choice *thisChoice = [[thisOption choiceList] objectAtIndex:[indexPath row]];
        [thisChoice toggleSelected];
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:[indexPath section]] withRowAnimation:UITableViewRowAnimationNone];        
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
    
    itemView = [[ItemView alloc] init];
    [[itemView itemTable] setDelegate:self];
    [[itemView itemTable] setDataSource:itemRenderer];
    
    [self setView:itemView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[itemView priceButton] setTitle:[NSString stringWithFormat:@"Item Price: %@",[Utilities FormatToPrice:[itemInfo totalPrice]] ]];
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

-(void) itemAltered
{
    [[itemView priceButton] setTitle:[NSString stringWithFormat:@"Item Price: %@",[Utilities FormatToPrice:[itemInfo totalPrice]] ]];
    [[itemView itemTable] reloadData];
}
@end
