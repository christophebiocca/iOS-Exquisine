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
#import "OrderTabView.h"
#import "AppData.h"
#import "Combo.h"
#import "Order.h"
#import "Item.h"
#import "Menu.h"

NSString *ORDER_PLACEMENT_REQUESTED = @"CroutonLabs/OrderPlacementRequested";

@implementation OrderTabViewController

-(id)initWithOrderManager:(OrderManager *)anOrderManager
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        theOrderManager = anOrderManager;
        orderView = [[OrderTabView alloc] init];
        orderRenderer = [[ShinyOrderTabRenderer alloc] initWithOrderManager:theOrderManager];
        
        [[orderView orderTable] setDelegate:self];
        [[orderView orderTable] setDataSource:orderRenderer];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [[[self navigationController] navigationBar] setBackgroundImage:[UIImage imageNamed:@"BlankTopbarWithShadow.png"] forBarMetrics:UIBarMetricsDefault];
    UILabel *toolbarText = [[UILabel alloc] initWithFrame:CGRectMake(
                                                            ([[[self navigationController] navigationBar] frame ].size.width - 300) / 2,
                                                            (44 - 30) / 2, 
                                                            300, 
                                                            30)];
    [toolbarText setFont:[UIFont fontWithName:@"Optima-ExtraBlack" size:22]];
    [toolbarText setTextColor:[UIColor whiteColor]];
    [toolbarText setBackgroundColor:[UIColor clearColor]];
    [toolbarText setTextAlignment:UITextAlignmentCenter];
    
    [toolbarText setText:@"Your Order"];
    
    //We're initing it again so that anything that has changed is accounted for.
    [orderRenderer initWithOrderManager:theOrderManager];
    [[orderView orderTable] reloadData];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView) name:ORDER_MANAGER_NEEDS_REDRAW object:theOrderManager];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(placeButtonPressed) name:PLACE_BUTTON_PRESSED object:orderRenderer];
    
    [[self navigationItem] setTitleView:toolbarText];
}

-(void) refreshView
{
    [self viewWillAppear:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[ExpandableCell class]])
    {
        [(ExpandableCell *)[tableView cellForRowAtIndexPath:indexPath] toggleOpen:indexPath :tableView];
    }
    else if ([[CustomViewCell cellIdentifierForData:[orderRenderer objectForCellAtIndex:indexPath]] isEqualToString:@"ShinyMenuItemCell"])
    {
        Item *theItem = [[orderRenderer objectForCellAtIndex:indexPath] objectForKey:@"menuItem"];
        
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
        
        NSLog(@"%@",newController);
        
        [[self navigationController] pushViewController:newController animated:YES];
    }
    else if ([[CustomViewCell cellIdentifierForData:[orderRenderer objectForCellAtIndex:indexPath]] isEqualToString:@"ShinyOrderItemCell"])
    {
        Item *theItem = [[orderRenderer objectForCellAtIndex:indexPath] objectForKey:@"orderItem"];
        
        ShinyOrderItemViewController *newController = [[ShinyOrderItemViewController alloc] initWithItem:theItem];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteItem:) name:ITEM_DELETE_BUTTON_HIT object:newController];
        
        [[self navigationController] pushViewController:newController animated:YES];
    }
    else if ([[CustomViewCell cellIdentifierForData:[orderRenderer objectForCellAtIndex:indexPath]] isEqualToString:@"ShinyComboOrderItemCell"])
    {
        Item *theItem = [[orderRenderer objectForCellAtIndex:indexPath] objectForKey:@"orderComboItem"];
        
        ShinyComboItemViewController *newController = [[ShinyComboItemViewController alloc] initWithItem:theItem];
        
        [[self navigationController] pushViewController:newController animated:YES];
    }
    else if ([[CustomViewCell cellIdentifierForData:[orderRenderer objectForCellAtIndex:indexPath]] isEqualToString:@"ShinyMenuComboCell"])
    {
        Combo *theCombo = [[orderRenderer objectForCellAtIndex:indexPath] objectForKey:@"menuCombo"];
        
        ShinyMenuComboViewController *newController;
        
        if ([[[[AppData appData] favoritesMenu] comboList] containsObject:theCombo]) {
            newController = [[ShinyMenuComboViewController alloc] initWithCombo:theCombo];
        }
        else {
            newController = [[ShinyMenuComboViewController alloc] initWithCombo:[theCombo copy]];
        }
        
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addCombo:) name:COMBO_DONE_BUTTON_HIT object:newController];
        
        [[self navigationController] pushViewController:newController animated:YES];
    }
    else if ([[CustomViewCell cellIdentifierForData:[orderRenderer objectForCellAtIndex:indexPath]] isEqualToString:@"ShinyOrderComboCell"])
    {
        Combo *theCombo = [[orderRenderer objectForCellAtIndex:indexPath] objectForKey:@"combo"];
        
        ShinyOrderComboViewController *newController = [[ShinyOrderComboViewController alloc] initWithCombo:theCombo];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteCombo:) name:COMBO_DELETE_BUTTON_HIT object:newController];
        
        [[self navigationController] pushViewController:newController animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CustomViewCell cellHeightForData:[orderRenderer objectForCellAtIndex:indexPath]];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


-(void)loadView
{
    [super loadView];
    [self setView:orderView];
}

-(void) addItem:(NSNotification *) notification
{
    if (([[[theOrderManager thisOrder] itemList] count] + [[[theOrderManager thisOrder] comboList] count]) == 0) {
        [[orderView orderTable] scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    else {
        [[orderView orderTable] scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
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
        [[orderView orderTable] scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    else {
        [[orderView orderTable] scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    [[theOrderManager thisOrder] addCombo:[(ShinyMenuComboViewController *)[notification object] theCombo]];
}

-(void) placeButtonPressed
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ORDER_PLACEMENT_REQUESTED object:theOrderManager];
}

@end
