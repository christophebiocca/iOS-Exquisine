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
#import "OrderTabView.h"
#import "Order.h"
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
        
        [[orderView orderTable] setDelegate:self];
        [[orderView orderTable] setDataSource:orderRenderer];
    }
    return self;
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

-(void) updateOrderSection;
{
    [orderRenderer updateOrderSection];
    [[orderView orderTable] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
