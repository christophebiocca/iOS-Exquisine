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
#import "OrderViewController.h"
#import "ItemView.h"
#import "Choice.h"
#import "Option.h"
#import "Utilities.h"
#import "ItemManagementDelegate.h"
#import "ComboViewController.h"
#import "NSMutableNumber.h"

@implementation ItemViewController

@synthesize itemInfo;
@synthesize delegate;

-(ItemViewController *)initWithItemAndOrderAndReturnController:(Item *) anItem:(Order *)anOrder:(UIViewController *) aController
{
    
    itemRenderer = [[ItemRenderer alloc] initWithItem:anItem];
    
    itemView = [[ItemView alloc] init];
    [[itemView itemTable] setDelegate:self];
    [[itemView itemTable] setDataSource:itemRenderer];
    
    returnController = aController;
    itemInfo = anItem;
    ownerOrder = anOrder;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemAltered) name:ITEM_MODIFIED object:anItem];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Add this item" style:UIBarButtonItemStyleDone target:self action:@selector(addThisItemToOrder)];
    
    if (![anOrder containsExactItem:anItem]) {
        [[self navigationItem] setRightBarButtonItem:doneButton];
        
        //This really isn't the way to be doing this. 
        //I should be subclassing item view controller.
        
    }
    
    [[self navigationItem] setTitle:anItem.name];
    
    [self itemAltered];
    
    return self;
}

-(void)addThisItemToOrder
{
    [delegate addItemForController:self];

    [[self navigationController] popToViewController:returnController animated:YES];
}

//Delegate functions
//***********************************************************

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    id thingAtIndexPath = [itemRenderer objectForCellAtIndex:indexPath];
    
    if ([thingAtIndexPath isKindOfClass:[Choice class]]) {
        [thingAtIndexPath toggleSelected];
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
    [self setView:itemView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Entered an item page"];
    [self itemAltered];
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
    UIBarButtonItem *doneButton = nil;
    
    if ([[itemInfo numberOfItems] intValue] == 1) 
    {
        doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Add this item" style:UIBarButtonItemStyleDone target:self action:@selector(addThisItemToOrder)];
        
        [[itemView priceButton] setTitle:[NSString stringWithFormat:@"1 Item: %@",[Utilities FormatToPrice:[itemInfo price]]]];
    }
    else
    {
        doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Add these items" style:UIBarButtonItemStyleDone target:self action:@selector(addThisItemToOrder)];
        
        [[itemView priceButton] setTitle:[NSString stringWithFormat:@"%i Items: %@",[[itemInfo numberOfItems] intValue], [Utilities FormatToPrice:[itemInfo price]]]];
    }
    
    if (![ownerOrder containsExactItem:itemInfo]) {
        [[self navigationItem] setRightBarButtonItem:doneButton];
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
