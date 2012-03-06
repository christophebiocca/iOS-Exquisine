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
#import "ItemViewController.h"
#import "ComboItemViewController.h"
#import "ItemGroupViewController.h"
#import "NSMutableNumber.h"

@implementation ComboViewController

@synthesize comboInfo;

-(id)initializeWithComboAndOrderAndReturnController:(Combo *)aCombo :(Order *)anOrder:(UIViewController *) aController
{
    orderInfo = anOrder;
    comboInfo = aCombo;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(comboChanged:) name:COMBO_MODIFIED object:aCombo];
    comboRenderer = [[ComboRenderer alloc] initWithCombo:aCombo]; 
    
    comboView = [[ComboView alloc] init];
    [[comboView comboTable] setDelegate:self];
    [[comboView comboTable] setDataSource:comboRenderer];
    
    returnController = aController;
    [[self navigationItem] setTitle:comboInfo.name];
    
    [self comboChanged:nil];
    
    return self;
}
//Delegate functions
//***********************************************************


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    id itemGroup = [[comboInfo listOfItemGroups] objectAtIndex:[indexPath row]];
        
    //If there's only one Item, and the item has no options, then it's selected by default
    //Therefore, don't do anything
    if (([[itemGroup listOfItems] count] == 1)&&([[(Item *)[[itemGroup listOfItems] objectAtIndex:0] options] count] == 0)){
        return;
    }
    
    ItemGroupViewController *groupController = [[ItemGroupViewController alloc] initWithItemGroupAndOrderAndReturnViewController:itemGroup :orderInfo :self];
    
    if ([[itemGroup listOfItems] count] == 1) {
        
        ComboItemViewController *itemController = [[ComboItemViewController alloc] initWithItemAndOrderAndReturnController:[[itemGroup listOfItems] objectAtIndex:0] :orderInfo :self];
        
        [itemController setDelegate:groupController];
        
        [[self navigationController] pushViewController:itemController animated:YES];
        return;
    }
    
    [[self navigationController] pushViewController:groupController animated:YES];
    
}

-(void)tableView:(UITableView *) tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *) indexPath
{
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
}

-(void)comboChanged:(NSNotification *)aNotification
{
    
    UIBarButtonItem *doneButton = nil;
    
    if ([[comboInfo numberOfCombos] intValue] == 1) 
    {
        doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Add This Combo" style:UIBarButtonItemStyleDone target:self action:@selector(addThisComboToOrder)];
        
        [[comboView priceButton] setTitle:[NSString stringWithFormat:@"1 Combo: %@",[Utilities FormatToPrice:[comboInfo price]]]];
    }
    else
    {
        doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Add These Combos" style:UIBarButtonItemStyleDone target:self action:@selector(addThisComboToOrder)];
        
        [[comboView priceButton] setTitle:[NSString stringWithFormat:@"%i Combos: %@"
                                        , [[comboInfo numberOfCombos] intValue], [Utilities FormatToPrice:[comboInfo price]], [[comboInfo numberOfCombos] intValue]]];
    }
    
    
    if ([comboInfo satisfied])
        [doneButton setEnabled:YES];
    else
        [doneButton setEnabled:NO];
    
    [[self navigationItem] setRightBarButtonItem:doneButton];
    
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
    [self setView:comboView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Viewed a combo page"];
    
    for (ItemGroup *itemGroup in [comboInfo listOfItemGroups]) {
        if (([[itemGroup listOfItems] count] == 1)&&([[(Item *)[[itemGroup listOfItems] objectAtIndex:0] options] count] == 0))
        {
            [itemGroup setSatisfyingItem:[[itemGroup listOfItems] objectAtIndex:0]];
        }
    }
    
    [[comboView comboTable] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self comboChanged:nil];
}

-(void)addThisComboToOrder
{
    [[LocalyticsSession sharedLocalyticsSession] tagEvent:[NSString stringWithFormat: @"Added %i combo(s) to the order", [[comboInfo numberOfCombos] intValue]]];
    
    [orderInfo addCombo:[comboInfo copy]];
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

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
