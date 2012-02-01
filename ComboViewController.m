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

@implementation ComboViewController

@synthesize comboInfo;

-(ComboViewController *)initializeWithComboAndOrder:(Combo *)aCombo :(Order *)anOrder
{
    orderInfo = anOrder;
    comboInfo = aCombo;
    comboRenderer = [[ComboRenderer alloc] initFromComboAndOrder:aCombo:anOrder];  
    [[self navigationItem] setTitle:comboInfo.name];
    
    return self;
}

//Delegate functions
//***********************************************************


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /*
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    NSMutableArray *displayList = [[NSMutableArray alloc] initWithArray:[menuInfo submenuList]];
    
    [displayList addObjectsFromArray:[menuInfo comboList]];
    
    id submenuThing = [displayList objectAtIndex:[indexPath row]];
    
    if([submenuThing isKindOfClass:[Item class]])
    {
        
        Item *newItem = [[Item alloc] initFromItem:submenuThing];
        
        ItemViewController *newView = [[ItemViewController alloc] initializeWithItemAndOrder:newItem :orderInfo];
        
        [[self navigationController] pushViewController:newView animated:YES];
    }
    if([submenuThing isKindOfClass:[Menu class]])
    {
        
        MenuViewController *newController = [[MenuViewController alloc] initializeWithMenuAndOrder:submenuThing :orderInfo];
        
        [[self navigationController] pushViewController:newController animated:YES];
        
    }
    
    if([submenuThing isKindOfClass:[Combo class]])
    {
        
        ComboViewController *newController = [[ComboViewController alloc] initializeWithComboAndOrder:submenuThing:orderInfo];
        
        [[self navigationController] pushViewController:newController animated:YES];
        
    }*/
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
