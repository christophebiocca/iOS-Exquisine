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
#import "ShinyItemViewController.h"
#import "OrderTabView.h"
#import "Order.h"
#import "Item.h"
#import "Menu.h"

@implementation OrderTabViewController

-(id)initWithOrderManager:(OrderManager *)anOrderManager
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        theOrderManager = anOrderManager;
        orderView = [[OrderTabView alloc] init];
        orderRenderer = [[ShinyOrderTabRenderer alloc] initWithOrderManager:theOrderManager];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateOrderSection) name:ORDER_MODIFIED object:[theOrderManager thisOrder]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editButtonPressed) name:EDIT_BUTTON_PRESSED object:orderRenderer];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(placeButtonPressed) name:PLACE_BUTTON_PRESSED object:orderRenderer];
        
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
    
    [[self navigationItem] setTitleView:toolbarText];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[CustomViewCell cellIdentifierForData:[orderRenderer objectForCellAtIndex:indexPath]] isEqualToString:@"ClosedShinyMenuCell"])
    {
        Menu *theMenu = [[orderRenderer objectForCellAtIndex:indexPath] objectForKey:@"menu"];
        [[[orderRenderer listData] objectAtIndex:[indexPath section]] removeObjectAtIndex:[indexPath row]];
        
        NSMutableDictionary *helperDict = nil;
        
        helperDict = [NSMutableDictionary dictionary];
        [helperDict setObject:theMenu forKey:@"openMenu"];
        
        [[[orderRenderer listData] objectAtIndex:[indexPath section]] insertObject:helperDict atIndex:[indexPath row]];
        
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        NSMutableArray *helperArray = [[NSMutableArray alloc] init];
        
        for (int i=1; i<([[theMenu submenuList] count] + [[theMenu comboList] count] + 1); i++)
        {
            NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + i) inSection:indexPath.section];
            [helperArray addObject:tmpIndexPath];
        }
        
        int i = [indexPath row] + 1;
        
        for (id eachItem in [theMenu submenuList]) {
            
            helperDict = [NSMutableDictionary dictionary];
            
            [helperDict setObject:eachItem forKey:@"menuItem"];
            
            [[[orderRenderer listData] objectAtIndex:[indexPath section]] insertObject:helperDict atIndex:i];
            i++;
        }
        
        for (id eachItem in [theMenu comboList]) {
            
            helperDict = [NSMutableDictionary dictionary];
            
            [helperDict setObject:eachItem forKey:@"menuCombo"];
            
            [[[orderRenderer listData] objectAtIndex:[indexPath section]] insertObject:helperDict atIndex:i];
            i++;
        }
        
        [tableView insertRowsAtIndexPaths:helperArray withRowAnimation:UITableViewRowAnimationTop];
        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[indexPath row] inSection:[indexPath section]] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }
    else if ([[CustomViewCell cellIdentifierForData:[orderRenderer objectForCellAtIndex:indexPath]] isEqualToString:@"OpenShinyMenuCell"])
    {
        Menu *theMenu = [[orderRenderer objectForCellAtIndex:indexPath] objectForKey:@"openMenu"];
        [[[orderRenderer listData] objectAtIndex:[indexPath section]] removeObjectAtIndex:[indexPath row]];
        
        NSMutableDictionary *helperDict = nil;
        
        helperDict = [NSMutableDictionary dictionary];
        [helperDict setObject:theMenu forKey:@"menu"];
        
        [[[orderRenderer listData] objectAtIndex:[indexPath section]] insertObject:helperDict atIndex:[indexPath row]];
        
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        NSMutableArray *helperArray = [[NSMutableArray alloc] init];
        
        for (int i=1; i<([[theMenu submenuList] count] + [[theMenu comboList] count] + 1); i++)
        {
            NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + i) inSection:indexPath.section];
            [helperArray addObject:tmpIndexPath];
        }
        
        int i = [indexPath row] + 1;
        
        for (id eachItem in [theMenu submenuList]) {
            
            [[[orderRenderer listData] objectAtIndex:[indexPath section]] removeObjectAtIndex:i];
        }
        
        for (id eachItem in [theMenu comboList]) {
            
            [[[orderRenderer listData] objectAtIndex:[indexPath section]] removeObjectAtIndex:i];
        }
        
        [tableView deleteRowsAtIndexPaths:helperArray withRowAnimation:UITableViewRowAnimationTop];
    }
    else if ([[CustomViewCell cellIdentifierForData:[orderRenderer objectForCellAtIndex:indexPath]] isEqualToString:@"ShinyMenuItemCell"])
    {
        Item *theItem = [[orderRenderer objectForCellAtIndex:indexPath] objectForKey:@"menuItem"];
        ShinyItemViewController *newController = [[ShinyItemViewController alloc] initWithItem:[theItem copy]];
         
        if (([[theItem options] count] == 0) && [[theItem desc] isEqualToString:@""] ) {
            [[theOrderManager thisOrder] addItem:theItem];
            [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            return;
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addItem:) name:ITEM_DONE_BUTTON_HIT object:newController];
        
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
    [[theOrderManager thisOrder] addItem:[(ShinyItemViewController *)[notification object] theItem]];
    [[orderView orderTable] scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(void) updateOrderSection;
{
    [orderRenderer updateOrderSection];
    [[orderView orderTable] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void) placeButtonPressed
{
    //Stuff here to do the placing of the order
}

-(void) editButtonPressed
{
    [[orderView orderTable] setEditing:YES animated:YES];
}

@end
