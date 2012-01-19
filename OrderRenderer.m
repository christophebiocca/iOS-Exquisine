//
//  OrderRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderRenderer.h"
#import "Order.h"
#import "ItemRenderer.h"
#import "Item.h"
#import "CellData.h"
#import "Utilities.h"

@implementation OrderRenderer

-(void) redraw
{
    [itemRenderList removeAllObjects];
    
    //This may actually result in two renderers being created for each item.
    //This may be a problem. We'll see.
    for (Item *currentItem in orderInfo.itemList) {
        [itemRenderList addObject:[[ItemRenderer alloc] initWithItem:currentItem]];
    }

    [[suffixList objectAtIndex:0] setCellDesc:[Utilities FormatToPrice:[orderInfo totalPrice]]];
}

-(OrderRenderer *)initWithOrder:(Order *)anOrder
{
    orderInfo = anOrder;
    displayLists = [[NSMutableArray alloc] initWithCapacity:0];
    suffixList = [[NSMutableArray alloc] initWithCapacity:0];
    
    itemRenderList = [[NSMutableArray alloc] initWithCapacity:0];
    
    [displayLists addObject:itemRenderList];
    [displayLists addObject:suffixList];
    
    CellData *newCell = [[CellData alloc] init];
    newCell.cellTitle = @"Total:";
    newCell.cellDesc = [Utilities FormatToPrice:[orderInfo totalPrice]];
    [suffixList addObject:newCell];
    
    CellData *secondNewCell = [[CellData alloc] init];
    secondNewCell.cellTitle = @"Add Item";
    secondNewCell.cellDesc = @"";
    secondNewCell.cellColour = [UIColor blueColor];
    [suffixList addObject:secondNewCell];
    
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

@end
