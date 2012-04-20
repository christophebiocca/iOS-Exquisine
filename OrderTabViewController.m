//
//  OrderTabViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderTabViewController.h"
#import "OrderManager.h"
#import "ShinyOrderTabRenderer.h"
#import "OrderSectionHeaderView.h"
#import "OrderSectionFooterView.h"
#import "MenuSectionHeaderView.h"
#import "ShinyMenuItemViewController.h"
#import "ExpandableCell.h"
#import "ShinyOrderItemViewController.h"
#import "ShinyMenuComboViewController.h"
#import "ShinyComboItemViewController.h"
#import "ShinyOrderComboViewController.h"
#import "AppData.h"
#import "Combo.h"
#import "Order.h"
#import "Item.h"
#import "Menu.h"

NSString *ORDER_PLACEMENT_REQUESTED = @"CroutonLabs/OrderPlacementRequested";

@implementation OrderTabViewController

-(id)initWithOrderManager:(OrderManager *)anOrderManager
{
    self = [super init];
    if (self) {
        theOrderManager = anOrderManager;
        renderer = [[ShinyOrderTabRenderer alloc] initWithOrderManager:theOrderManager];
        
        [theTableView setDataSource:renderer];

    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [(UILabel *)[[self navigationItem] titleView] setText:@"Your Order"];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView) name:ORDER_MANAGER_NEEDS_REDRAW object:theOrderManager];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(placeButtonPressed) name:PLACE_BUTTON_PRESSED object:renderer];
}

-(void)viewWillAppear:(BOOL)animated
{
    //We're initing it again so that anything that has changed is accounted for.
    (void)[(ShinyOrderTabRenderer *)renderer initWithOrderManager:theOrderManager];
    [theTableView reloadData];
}


-(void)ShinyOrderItemCellHandler:(NSIndexPath *)indexPath
{
    Item *theItem = [[renderer objectForCellAtIndex:indexPath] objectForKey:@"orderItem"];
    
    ShinyOrderItemViewController *newController = [[ShinyOrderItemViewController alloc] initWithItem:theItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteItem:) name:ITEM_DELETE_BUTTON_HIT object:newController];
    
    [[self navigationController] pushViewController:newController animated:YES];
}

-(void)ShinyOrderComboCellHandler:(NSIndexPath *)indexPath
{
    Combo *theCombo = [[renderer objectForCellAtIndex:indexPath] objectForKey:@"combo"];
    
    ShinyOrderComboViewController *newController = [[ShinyOrderComboViewController alloc] initWithCombo:theCombo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteCombo:) name:COMBO_DELETE_BUTTON_HIT object:newController];
    
    [[self navigationController] pushViewController:newController animated:YES];
}

-(void)ShinyMenuItemCellHandler:(NSIndexPath *)indexPath
{
    
    Item *theItem = [[renderer objectForCellAtIndex:indexPath] objectForKey:@"menuItem"];
    
    ShinyMenuItemViewController *newController;
    
    //We need to make sure that this item isn't a favorites list item
    if ([[[[AppData appData] favoritesMenu] submenuList] containsObject:theItem]) {
        //if it is, we shouldn't copy it when we make the view controller
        newController = [[ShinyMenuItemViewController alloc] initWithItem:theItem];
    }
    else
    {
        newController = [[ShinyMenuItemViewController alloc] initWithItem:[theItem copy]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addItem:) name:ITEM_DONE_BUTTON_HIT object:newController];
    
    [[self navigationController] pushViewController:newController animated:YES];
}

-(void)ShinyMenuComboCellHandler:(NSIndexPath *)indexPath
{
    Combo *theCombo = [[renderer objectForCellAtIndex:indexPath] objectForKey:@"menuCombo"];
    
    ShinyMenuComboViewController *newController = [[ShinyMenuComboViewController alloc] initWithCombo:theCombo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addCombo:) name:COMBO_DONE_BUTTON_HIT object:newController];
    
    [[self navigationController] pushViewController:newController animated:YES];
}

-(void) refreshView
{
    [self viewWillAppear:YES];
    [self viewDidAppear:YES];
}

-(void) addItem:(NSNotification *) notification
{
    if (([[[theOrderManager thisOrder] itemList] count] + [[[theOrderManager thisOrder] comboList] count]) == 0) {
        [theTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    else {
        [theTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    [[theOrderManager thisOrder] addItem:[(ShinyMenuItemViewController *)[notification object] theItem]];
}

-(void) deleteItem:(NSNotification *) notification
{
    [[theOrderManager thisOrder] removeItem:[(ShinyOrderItemViewController *)[notification object] theItem]];
}

-(void) deleteCombo:(NSNotification *) notification
{
    [[theOrderManager thisOrder] removeCombo:[(ShinyOrderComboViewController *)[notification object] theCombo]];
}

-(void) addCombo:(NSNotification *) notification
{
    if (([[[theOrderManager thisOrder] itemList] count] + [[[theOrderManager thisOrder] comboList] count]) == 0) {
        [theTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    else {
        [theTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    [[theOrderManager thisOrder] addCombo:[(ShinyMenuComboViewController *)[notification object] theCombo]];
}

-(void) placeButtonPressed
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ORDER_PLACEMENT_REQUESTED object:theOrderManager];
}

@end
