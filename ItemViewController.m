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

@implementation ItemViewController

@synthesize itemInfo;
@synthesize delegate;

-(ItemViewController *)initializeWithItemAndOrderAndReturnController:(Item *) anItem:(Order *)anOrder:(UIViewController *) aController
{
    
    numberOfItems = 1;
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
        if (![returnController isKindOfClass:[ComboViewController class]]) {
            UIBarButtonItem *minusSignButton = [[UIBarButtonItem alloc] initWithTitle:@"-" style:UIBarButtonItemStylePlain target:self action:@selector(minusButtonPressed)];
            
            UIBarButtonItem *spacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
            
            UIBarButtonItem *spacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
            
            UIBarButtonItem *plusSignButton = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(plusButtonPressed)];
            
            [[itemView itemToolBar] setItems:[NSArray arrayWithObjects:minusSignButton, spacer1,[itemView priceButton],spacer2, plusSignButton, nil]];
        }
        
    }
    
    [[self navigationItem] setTitle:anItem.name];
    
    [self itemAltered];
    
    return self;
}

-(void)addThisItemToOrder
{
    for (int i = 0; i < numberOfItems; i++) {
        [delegate addItemForController:self];
    }

    [[self navigationController] popToViewController:returnController animated:YES];
    
}

//Delegate functions
//***********************************************************

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    if(![[itemInfo desc] isEqualToString:@""])
    {
        if([indexPath section] > 0)
        {
            Option *thisOption = [[itemInfo options] objectAtIndex:([indexPath section] - 1)];
            Choice *thisChoice = [[thisOption choiceList] objectAtIndex:[indexPath row]];
            [thisChoice toggleSelected];
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:([indexPath section] - 1)] withRowAnimation:UITableViewRowAnimationNone];
        }
        return;
    }
    
    Option *thisOption = [[itemInfo options] objectAtIndex:[indexPath section]];
    Choice *thisChoice = [[thisOption choiceList] objectAtIndex:[indexPath row]];
    [thisChoice toggleSelected];
    //[tableView reloadSections:[NSIndexSet indexSetWithIndex:[indexPath section]] withRowAnimation:UITableViewRowAnimationNone];
    
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

-(void)plusButtonPressed
{
    numberOfItems++;
    [self itemAltered];
}

-(void)minusButtonPressed
{
    if (numberOfItems != 1) {
        numberOfItems--;
        [self itemAltered];
    }
}

-(void) itemAltered
{
    UIBarButtonItem *doneButton = nil;
    
    if (numberOfItems == 1) 
    {
        doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Add this item" style:UIBarButtonItemStyleDone target:self action:@selector(addThisItemToOrder)];
        
        [[itemView priceButton] setTitle:[NSString stringWithFormat:@"1 Item: %@",[Utilities FormatToPrice:[itemInfo price]]]];
    }
    else
    {
        doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Add these items" style:UIBarButtonItemStyleDone target:self action:@selector(addThisItemToOrder)];
        
        [[itemView priceButton] setTitle:[NSString stringWithFormat:@"%i Items: %@",numberOfItems, [Utilities FormatToPrice:[[itemInfo price] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%i", numberOfItems]]]]]];
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
