//
//  ShinyItemViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyMenuItemViewController.h"
#import "Item.h"
#import "Option.h"
#import "ShinyItemView.h"
#import "Choice.h"
#import "Menu.h"
#import "AppData.h"
#import "ShinyMenuItemRenderer.h"
#import "ShinyItemFavoriteCell.h"
#import "ShinyChoiceCell.h"
#import "ExpandableCell.h"


NSString* ITEM_DONE_BUTTON_HIT = @"CroutonLabs/ItemDoneButtonHit";

@implementation ShinyMenuItemViewController

@synthesize theItem;

-(id)initWithItem:(Item *)anItem
{
    self = [super init];
    if (self) 
    {
        theItem = anItem;
        renderer = [[ShinyMenuItemRenderer alloc] initWithItem:theItem];
        [theTableView setDataSource:renderer];
        
    }
    return self;
}

-(void)ShinyItemFavoriteCellHandler:(NSIndexPath *)indexPath
{
    if ([[[[AppData appData] favoritesMenu] submenuList] containsObject:theItem]) {
        [[self navigationController] popViewControllerAnimated:YES];
    }
    [super ShinyItemFavoriteCellHandler:indexPath];
}

-(void)loadView
{
    [super loadView];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonHit)];
    
    [[self navigationItem] setRightBarButtonItem:doneButton];
}

-(void) doneButtonHit
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ITEM_DONE_BUTTON_HIT object:self];
    [[self navigationController] popViewControllerAnimated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [(UILabel *)[[self navigationItem] titleView] setText:[theItem name]];
}

@end
