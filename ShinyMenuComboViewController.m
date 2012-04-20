//
//  ShinyComboViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyMenuComboViewController.h"
#import "ShinyMenuComboRenderer.h"
#import "ShinyComboView.h"
#import "ShinyMenuItemViewController.h"
#import "ShinyItemGroupViewController.h"
#import "ShinyComboItemViewController.h"
#import "ShinyComboFavoriteCell.h"
#import "Combo.h"
#import "ExpandableCell.h"
#import "ItemGroup.h"
#import "AppData.h"
#import "Menu.h"
#import "Item.h"

NSString *COMBO_DONE_BUTTON_HIT = @"CroutonLabs/ComboDoneButtonHit";

@implementation ShinyMenuComboViewController

@synthesize theCombo;

-(id)initWithCombo:(Combo *)aCombo
{
    self = [super init];
    if (self) 
    {
        theCombo = aCombo;
        renderer = [[ShinyMenuComboRenderer alloc] initWithCombo:theCombo];
        [theTableView setDataSource:renderer];
    }
    return self;
}

-(void)ShinyComboFavoriteCellHandler:(NSIndexPath *)indexPath
{
    if ([[[[AppData appData] favoritesMenu] comboList] containsObject:theCombo] ) {
        [[self navigationController] popViewControllerAnimated:YES];
    }
    [super ShinyComboFavoriteCellHandler:indexPath];
}

-(void)ShinyItemGroupCellHandler:(NSIndexPath *)indexPath
{
    ItemGroup *theItemGroup = [renderer objectForCellAtIndex:indexPath];        
    
    if ([[theItemGroup listOfItems] count] == 1) {
        Item *theItem = [[theItemGroup listOfItems] objectAtIndex:0];
        if (([[theItem options] count] > 0)||![[theItem desc] isEqualToString:@""]) 
        {
            ShinyComboItemViewController *newController = [[ShinyComboItemViewController alloc] initWithItem:theItem];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addItemButtonHit:) name:ITEM_DONE_BUTTON_HIT object:newController];
            [[self navigationController] pushViewController:newController animated:YES];
            return;
        }
        else {
            return;
        }
    }
    else {
        ShinyItemGroupViewController *newController = [[ShinyItemGroupViewController alloc] initWithItemGroup:theItemGroup];
        [[self navigationController] pushViewController:newController animated:YES];
    }
}

-(void)loadView
{
    [super loadView];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonHit)];
    [[self navigationItem] setRightBarButtonItem:doneButton];
}

-(void) addItemButtonHit:(NSNotification *) aNotification
{
    [theCombo addItem:[(ShinyMenuItemViewController *)[aNotification object] theItem]];
}

-(void) doneButtonHit
{
    [[NSNotificationCenter defaultCenter] postNotificationName:COMBO_DONE_BUTTON_HIT object:self];
    [[self navigationController] popViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [(UILabel *)[[self navigationItem] titleView] setText:[theCombo name]];
    
    if ([theCombo satisfied]) {
        [[[self navigationItem] rightBarButtonItem] setEnabled:YES];
    }
    else{
        [[[self navigationItem] rightBarButtonItem] setEnabled:NO];
    }
}

@end
