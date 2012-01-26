//
//  ItemRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemRenderer.h"
#import "Item.h"
#import "Option.h"
#import "OptionRenderer.h"
#import "CellData.h"
#import "Utilities.h"

@implementation ItemRenderer

@synthesize itemInfo;

-(void) redraw
{
    [optionRenderList removeAllObjects];
    //This may actually result in two renderers being created for each item.
    //This may be a problem. We'll see.
    for (Option *currentOption in itemInfo.options) {
        [optionRenderList addObject:[[OptionRenderer alloc] initWithOption:currentOption]];
    }
    [[suffixList objectAtIndex:1] setCellDesc:[Utilities FormatToPrice:[itemInfo totalPrice]]];
}

-(ItemRenderer *)initWithItem:(Item *)anItem
{
    itemInfo = anItem;
    
    displayLists = [[NSMutableArray alloc] initWithCapacity:0];
    suffixList = [[NSMutableArray alloc] initWithCapacity:0];
    
    if([itemInfo.options count] == 0)
    {
        CellData *aCell = [[CellData alloc] init];
        aCell.cellTitle = @"No Options";
        aCell.cellDesc = @"";
        [suffixList addObject:aCell];
    }
    
    optionRenderList = [[NSMutableArray alloc] initWithCapacity:0];
    
    [displayLists addObject:optionRenderList];
    [displayLists addObject:suffixList];
    
    CellData *newCell = [[CellData alloc] init];
    newCell.cellTitle = @"Base Price: ";
    newCell.cellDesc = [Utilities FormatToPrice:[itemInfo basePrice]];
    [suffixList addObject:newCell];
    
    CellData *secondNewCell = [[CellData alloc] init];
    secondNewCell.cellTitle = @"Total Item Price:";
    secondNewCell.cellDesc = [Utilities FormatToPrice:[itemInfo totalPrice]];
    [suffixList addObject:secondNewCell];
    
    return self;
}

-(UITableViewCell *)configureCell:(UITableViewCell *)aCell
{
    [[aCell detailTextLabel] setText:[Utilities FormatToPrice:itemInfo.totalPrice]];
    [[aCell textLabel] setText:itemInfo.name];
    if([[itemInfo options] count] > 0)
    {
        [aCell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    }
    else
    {
        [aCell setAccessoryType:UITableViewCellAccessoryNone];
    }
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
    
    [[Utilities MemberOfCompositeListAtIndex:displayLists:[indexPath row]] configureCell:cell];
    
    return cell;
}


@end
