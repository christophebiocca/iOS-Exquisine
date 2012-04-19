//
//  ListViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListViewController.h"
#import "ListRenderer.h"
#import "ExpandableCell.h"
#import "ShinyMenuItemViewController.h"
#import "ShinyOrderItemViewController.h"
#import "ShinyMenuComboViewController.h"
#import "ShinyComboItemViewController.h"
#import "ShinyOrderComboViewController.h"
#import "ShinyItemGroupViewController.h"
#import "ShinyOrderSummaryViewController.h"
#import "ShinyChoiceCell.h"
#import "ShinyItemFavoriteCell.h"
#import "ShinyComboFavoriteCell.h"
#import "Item.h"
#import "Menu.h"
#import "ItemGroup.h"
#import "Choice.h"
#import "Combo.h"
#import "AppData.h"

@implementation ListViewController

-(id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) 
    {
        theTableView = [[UITableView alloc] init];
        [theTableView setDelegate:self];
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
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellClassName = [CustomViewCell cellIdentifierForData:[renderer objectForCellAtIndex:indexPath]];
    
    SEL aSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@",cellClassName,@"Handler:"]);
    
    if ([self respondsToSelector:aSelector]) {
        [self performSelector:aSelector withObject:indexPath];
    }
    
    if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[ExpandableCell class]])
    {
        [(ExpandableCell *)[tableView cellForRowAtIndexPath:indexPath] toggleOpen:indexPath :tableView];
    }
}


-(void)ShinyMenuItemCellHandler:(NSIndexPath *) indexPath
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
    
    [[self navigationController] pushViewController:newController animated:YES];
}

-(void)ShinyOrderItemCellHandler:(NSIndexPath *)indexPath
{
    Item *theItem = [[renderer objectForCellAtIndex:indexPath] objectForKey:@"orderItem"];
    
    ShinyOrderItemViewController *newController = [[ShinyOrderItemViewController alloc] initWithItem:theItem];
    
    [[self navigationController] pushViewController:newController animated:YES];
}

-(void)ShinyComboOrderItemCellHandler:(NSIndexPath *) indexPath
{
    Item *theItem = [[renderer objectForCellAtIndex:indexPath] objectForKey:@"orderComboItem"];
    
    ShinyComboItemViewController *newController = [[ShinyComboItemViewController alloc] initWithItem:theItem];
    
    [[self navigationController] pushViewController:newController animated:YES];
}

-(void)ShinyMenuComboCellHandler:(NSIndexPath *) indexPath
{
    Combo *theCombo = [[renderer objectForCellAtIndex:indexPath] objectForKey:@"menuCombo"];
    
    ShinyMenuComboViewController *newController;
    
    if ([[[[AppData appData] favoritesMenu] comboList] containsObject:theCombo]) {
        newController = [[ShinyMenuComboViewController alloc] initWithCombo:theCombo];
    }
    else {
        newController = [[ShinyMenuComboViewController alloc] initWithCombo:[theCombo copy]];
    }
    
    [[self navigationController] pushViewController:newController animated:YES];
}

-(void)ShinyOrderComboCellHandler:(NSIndexPath *) indexPath
{
    Combo *theCombo = [[renderer objectForCellAtIndex:indexPath] objectForKey:@"combo"];
    
    ShinyOrderComboViewController *newController = [[ShinyOrderComboViewController alloc] initWithCombo:theCombo];
    
    [[self navigationController] pushViewController:newController animated:YES];
}

-(void)ShinyChoiceCellHandler:(NSIndexPath *)indexPath
{
    Choice *theChoice = [[renderer objectForCellAtIndex:indexPath] objectForKey:@"choice"];
    [theChoice toggleSelected];
    [(ShinyChoiceCell *)[theTableView cellForRowAtIndexPath:indexPath] pulseView];
}

-(void)ShinyItemGroupCellHandler:(NSIndexPath *)indexPath
{
    ItemGroup *theItemGroup = [renderer objectForCellAtIndex:indexPath];        
    
    if ([[theItemGroup listOfItems] count] == 1) {
        Item *theItem = [[theItemGroup listOfItems] objectAtIndex:0];
        if (([[theItem options] count] > 0)||![[theItem desc] isEqualToString:@""]) 
        {
            ShinyComboItemViewController *newController = [[ShinyComboItemViewController alloc] initWithItem:theItem];
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

-(void)ShinyItemFavoriteCellHandler:(NSIndexPath *)indexPath
{
    [(ShinyItemFavoriteCell *)[theTableView cellForRowAtIndexPath:indexPath] wasClicked];
}

-(void)ShinySettingsCellHandler:(NSIndexPath *)indexPath
{
    //Do nothing, the subclass is the better guy to deal with this.
}

-(void)ShinyComboFavoriteCellHandler:(NSIndexPath *)indexPath
{
     [(ShinyComboFavoriteCell *)[theTableView cellForRowAtIndexPath:indexPath] wasClicked];
}

-(void)ShinyOrderHistoryCellHandler:(NSIndexPath *)indexPath
{
    Order *theOrder = [[renderer objectForCellAtIndex:indexPath] objectForKey:@"historicalOrder"];
    
    ShinyOrderSummaryViewController *newController = [[ShinyOrderSummaryViewController alloc] initWithOrder:theOrder];
    
    [[self navigationController] pushViewController:newController animated:YES];
}

-(void)ShinyDeleteCellHandler:(NSIndexPath *)indexPath
{
    //This should be dealt with by the subclass
}

-(void)ShinyPaymentViewCellHandler:(NSIndexPath *)indexPath
{
    //This one too.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CustomViewCell cellHeightForData:[renderer objectForCellAtIndex:indexPath]];
}

-(void)loadView
{
    [super loadView];
    [self setView:theTableView];
}

@end
