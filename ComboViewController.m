//
//  ComboViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-31.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComboViewController.h"
#import "ComboView.h"
#import "ComboRenderer.h"
#import "Combo.h"
#import "Order.h"
#import "ItemGroup.h"
#import "Item.h"
#import "ItemGroupViewController.h"

@implementation ComboViewController

@synthesize comboInfo;

-(ComboViewController *)initializeWithComboAndOrderAndReturnController:(Combo *)aCombo :(Order *)anOrder:(UIViewController *) aController
{
    orderInfo = anOrder;
    comboInfo = aCombo;
    comboRenderer = [[ComboRenderer alloc] initFromComboAndOrder:aCombo:anOrder]; 
    returnController = aController;
    [[self navigationItem] setTitle:comboInfo.name];
    
    return self;
}

//Delegate functions
//***********************************************************


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    id itemGroup = [[comboInfo listOfItemGroups] objectAtIndex:[indexPath row]];
        
    ItemGroupViewController *newController = [[ItemGroupViewController alloc] initWithItemGroupAndOrderAndReturnViewController:itemGroup :orderInfo :self];
        
    [[self navigationController] pushViewController:newController animated:YES];
    
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
    comboView = [[ComboView alloc] init];
    [[comboView comboTable] setDelegate:self];
    [[comboView comboTable] setDataSource:comboRenderer];
    
    [self setView:comboView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[comboView comboTable] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Add This Combo" style:UIBarButtonItemStyleDone target:self action:@selector(addThisComboToOrder)];
    
    if ([comboInfo satisfied])
        [doneButton setEnabled:YES];
    else
        [doneButton setEnabled:NO];

    [[self navigationItem] setRightBarButtonItem:doneButton];
}

-(void)addThisComboToOrder
{
    for (ItemGroup *anItemGroup in [comboInfo listOfItemGroups]) {
        [orderInfo addItem:[[anItemGroup satisfyingItem] copy]];
    }
    [comboInfo removeAllItems];
    [[self navigationController]popToViewController:returnController animated:YES];
    
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
