//
//  OrderRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderRenderer.h"
#import "ComboRenderer.h"
#import "Order.h"
#import "ItemRenderer.h"
#import "Item.h"
#import "CellData.h"
#import "Combo.h"
#import "Utilities.h"
#import "Menu.h"

@implementation OrderRenderer

-(void) redraw
{
    //Purge the render lists
    [itemRenderList removeAllObjects];
    [comboRenderList removeAllObjects];
    
    for (Combo *aCombo in [orderInfo listOfCombos]) 
    {
        ComboRenderer *newComboRenderer = [[ComboRenderer alloc] initFromCombo:aCombo];
        [comboRenderList addObjectsFromArray:[newComboRenderer produceRenderList]];
    }
    
    for (Item *currentItem in [orderInfo listOfNonComboItems] )  
    {
        [itemRenderList addObject:[[ItemRenderer alloc] initWithItem:currentItem]];
    }
    
    [[suffixList objectAtIndex:0] setCellDesc:[Utilities FormatToPrice:[orderInfo subtotalPrice]]];
    [[suffixList objectAtIndex:1] setCellDesc:[Utilities FormatToPrice:[orderInfo taxPrice]]];
    [[suffixList objectAtIndex:2] setCellDesc:[Utilities FormatToPrice:[orderInfo totalPrice]]];
}

-(OrderRenderer *)initWithOrderAndMenu:(Order *)anOrder:(Menu *) aMenu
{
    theMenu = aMenu;
    orderInfo = anOrder;
    displayLists = [[NSMutableArray alloc] initWithCapacity:0];
    suffixList = [[NSMutableArray alloc] initWithCapacity:0];
    
    itemRenderList = [[NSMutableArray alloc] initWithCapacity:0];
    comboRenderList = [[NSMutableArray alloc] initWithCapacity:0];

    [displayLists addObject:itemRenderList];
    [displayLists addObject:comboRenderList];
    [displayLists addObject:suffixList];
    
    CellData *newCell = nil;
    
    newCell = [[CellData alloc] init];
    newCell.cellTitle = @"Subtotal:";
    newCell.cellDesc = [Utilities FormatToPrice:[orderInfo subtotalPrice]];
    [suffixList addObject:newCell];
    
    newCell = [[CellData alloc] init];
    newCell.cellTitle = @"HST:";
    newCell.cellDesc = [Utilities FormatToPrice:[orderInfo taxPrice]];
    [suffixList addObject:newCell];
    
    newCell = [[CellData alloc] init];
    newCell.cellTitle = @"Total:";
    newCell.cellDesc = [Utilities FormatToPrice:[orderInfo totalPrice]];
    [suffixList addObject:newCell];
    
    newCell = [[CellData alloc] init];
    newCell.cellTitle = @"Add Item";
    newCell.cellDesc = @"";
    newCell.cellAccessory = @"plus";
    newCell.cellColour = [UIColor blueColor];
    [suffixList addObject:newCell];
    
    [self redraw];
    
    return self;
}

-(UITableViewCell *)configureCell:(UITableViewCell *)aCell
{
    [[aCell detailTextLabel] setText:[Utilities FormatToPrice:orderInfo.totalPrice]];
    [[aCell textLabel] setText:orderInfo.name];
    [aCell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    return aCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int memberTally = 0;
    
    for (NSMutableArray *componentList in displayLists) {
        memberTally += [componentList count];
    }
    
    return memberTally;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    [[Utilities MemberOfCompositeListAtIndex:displayLists:[indexPath row]]  configureCell:cell];
    
    return cell;
}

-(id)objectForCellAtIndex:(NSIndexPath *)index
{
    return [Utilities MemberOfCompositeListAtIndex:displayLists :[index row]];
}

@end
