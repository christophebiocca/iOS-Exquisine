//
//  OrderSummaryRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderSummaryRenderer.h"
#import "Combo.h"
#import "ComboRenderer.h"
#import "Order.h"
#import "Item.h"
#import "ItemRenderer.h"
#import "Utilities.h"
#import "CellData.h"

@implementation OrderSummaryRenderer

@synthesize displayLists;

-(void) redraw
{
    //Purge the render lists
    [itemRenderList removeAllObjects];
    [comboRenderList removeAllObjects];
    
    for (Combo *aCombo in [orderInfo comboList]) 
    {
        ComboRenderer *newComboRenderer = [[ComboRenderer alloc] initFromCombo:aCombo];
        [comboRenderList addObjectsFromArray:[newComboRenderer detailedStaticRenderList]];
    }
    
    for (Item *currentItem in [orderInfo itemList] )  
    {
        [itemRenderList addObjectsFromArray:[[[ItemRenderer alloc] initWithItem:currentItem] detailedStaticRenderList]];
    }
    
    [[suffixList objectAtIndex:0] setCellDesc:[Utilities FormatToPrice:[orderInfo subtotalPrice]]];
    [[suffixList objectAtIndex:1] setCellDesc:[Utilities FormatToPrice:[orderInfo taxPrice]]];
    [[suffixList objectAtIndex:2] setCellDesc:[Utilities FormatToPrice:[orderInfo totalPrice]]];
}

-(OrderSummaryRenderer *)initWithOrder:(Order *)anOrder
{
    self = [super init];
    
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
    [newCell setCellTitleFontSize:17];
    [newCell setCellDescFontSize:17];
    [newCell setCellTitleFontType:@"HelveticaNeue-Medium"];
    [newCell setCellDescFontType:@"HelveticaNeue"];
    newCell.cellTitle = @"Subtotal:";
    newCell.cellDesc = [Utilities FormatToPrice:[orderInfo subtotalPrice]];
    [suffixList addObject:newCell];
    
    newCell = [[CellData alloc] init];
    [newCell setCellTitleFontSize:17];
    [newCell setCellDescFontSize:17];
    [newCell setCellTitleFontType:@"HelveticaNeue-Medium"];
    [newCell setCellDescFontType:@"HelveticaNeue"];
    newCell.cellTitle = @"HST:";
    newCell.cellDesc = [Utilities FormatToPrice:[orderInfo taxPrice]];
    [suffixList addObject:newCell];
    
    newCell = [[CellData alloc] init];
    [newCell setCellTitleFontSize:17];
    [newCell setCellDescFontSize:17];
    [newCell setCellTitleFontType:@"HelveticaNeue-Medium"];
    [newCell setCellDescFontType:@"HelveticaNeue"];
    newCell.cellTitle = @"Total:";
    newCell.cellDesc = [Utilities FormatToPrice:[orderInfo totalPrice]];
    [suffixList addObject:newCell];
    
    [self redraw];
    
    return self;
}

-(UITableViewCell *)configureCell:(UITableViewCell *)aCell
{
    [[aCell detailTextLabel] setText:[Utilities FormatToPrice:orderInfo.totalPrice]];
    [[aCell textLabel] setText:orderInfo.name];
    [aCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return aCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [Utilities CompositeListCount:displayLists];
    
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
