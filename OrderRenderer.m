//
//  OrderRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Utilities.h"
#import "OrderRenderer.h"
#import "MenuCell.h"
#import "ItemMenuCell.h"
#import "ItemOrderCell.h"
#import "ComboCell.h"
#import "Menu.h"
#import "Order.h"
#import "Item.h"
#import "Combo.h"
#import "CellData.h"
#import "OrderManager.h"

@implementation OrderRenderer


-(OrderRenderer *)initWithOrderManager:(OrderManager *)anOrderManager
{
    
    self = [super initWithMenuComponent:[anOrderManager thisOrder]];
    
    orderManager = anOrderManager;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshOrderList:) name:ORDER_MANAGER_NEEDS_REDRAW object:orderManager];
    
    orderDisplayList = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self refreshOrderList:nil];
    
    return self;
}


//Eventually we can call this intelligently.
-(void) refreshOrderList:(NSNotification *)aNotification
{
    [orderDisplayList removeAllObjects];
    
    for (Combo *combo in  [[orderManager thisOrder] comboList]) 
    {
        [orderDisplayList addObject:combo];
        [orderDisplayList addObjectsFromArray:[combo listOfAssociatedItems]];
    }
    
    [orderDisplayList addObjectsFromArray:[[orderManager thisOrder] itemList]];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (section) {
            
        case 0:
            if([orderDisplayList count] > 0)
                return ([orderDisplayList count]);
            else
                return 1;
        case 1:
            return [[[orderManager thisMenu] submenuList] count];
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch ([indexPath section]) {
        case 0:
            return [self itemCellForIndexPath:tableView:indexPath];
            break;
        case 1:
            return [self menuCellForIndexPath:tableView:indexPath];
            break;
        default:
            break;
    }
    
    return nil;
}

- (UITableViewCell *)menuCellForIndexPath:(UITableView *) tableView:(NSIndexPath *) indexPath
{
    
    id thingToDisplay = [[[orderManager thisMenu] submenuList] objectAtIndex:[indexPath row]];
    
    if([thingToDisplay isKindOfClass:([Item class])])
    {
        ItemMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:[ItemMenuCell cellIdentifier]];
        if (cell == nil) {
            cell = [[ItemMenuCell alloc] init];
        }
        
        [cell setItem:thingToDisplay];
        return cell;
    }
    else if([thingToDisplay isKindOfClass:([Menu class])])
    {
        MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:[MenuCell cellIdentifier]];
        if (cell == nil) {
            cell = [[MenuCell alloc] init];
        }
        [cell setMenu:thingToDisplay];
        return cell;
    }
    
    return nil;
}

- (UITableViewCell *)itemCellForIndexPath:(UITableView *) tableView:(NSIndexPath *) indexPath
{
    if([orderDisplayList count] > 0)
    {
        id thingToDisplay = [orderDisplayList objectAtIndex:[indexPath row]];
        
        if([thingToDisplay isKindOfClass:([Item class])])
        {
            ItemOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:[ItemOrderCell cellIdentifier]];
            if (cell == nil) {
                cell = [[ItemOrderCell alloc] init];
            }
            
            [cell setItem:thingToDisplay];
            
            [cell setIndentationLevel:0];
            
            if (![[[orderManager thisOrder] itemList] containsObject:thingToDisplay])
            {
                [cell setIndentationLevel:1];
                [[cell detailTextLabel] setText:@""];
            }
            
            return cell;
        }
        else if([thingToDisplay isKindOfClass:([Combo class])])
        {
            ComboCell *cell = [tableView dequeueReusableCellWithIdentifier:[ComboCell cellIdentifier]];
            if (cell == nil) {
                cell = [[ComboCell alloc] init];
            }
            [cell setStyle:@"with_price"];
            [cell setCombo:thingToDisplay];
            return cell;
        }
        
        return nil;
    }
    else
    {
        
        //if the order is empty, we need to put something there to tell people.
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        
        
        CellData *newCell = [[CellData alloc] init];
        [newCell setCellTitle:@"You have no items in your order"];
        [newCell setCellDesc:@""];
        
        [newCell setCellTitleFontSize: 13];
        [newCell setCellTitleFontType: @"HelveticaNeue-Medium"];
        [newCell setCellDescFontSize: 13];
        [newCell setCellDescFontType: @"HelveticaNeue"];
        
        [newCell configureCell:cell];
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) 
    {
        //first we check if it's an item:
        id cellObject = [self objectForCellAtIndex:indexPath];
        //Then see if it's an item:
        if ([cellObject isKindOfClass:[Item class]])
        {
            [[orderManager thisOrder] removeItem:cellObject];
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            if([orderDisplayList count] == 0)
                [tableView setEditing:NO animated:YES];
        }
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        //do more stuff
    }
    else if (editingStyle == UITableViewCellEditingStyleNone)
    {
        //do more more stuff
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //To assess whether we can edit the row, we grab the cell renderer:
    id cellObject = [self objectForCellAtIndex:indexPath];
    //Then see if it's an item:
    if ([cellObject isKindOfClass:[Item class]])
    {
        //if so,  we can edit it.
        return YES;
    }
    return NO;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Your Order";
            break;
        case 1:
            return @"Menu";
            break;
        default:
            break;
    }
    return nil;
}

-(id)objectForCellAtIndex:(NSIndexPath *)index
{
    if ([index section] == 0) {
        if ( [orderDisplayList count] > 0)
            return [orderDisplayList objectAtIndex:[index row]];
    }
    if ([index section] == 1)
        return [[[orderManager thisMenu] submenuList] objectAtIndex:[index row]];
    
    return nil;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
