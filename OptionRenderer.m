//
//  OptionRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OptionRenderer.h"
#import "Option.h"
#import "Choice.h"
#import "ChoiceRenderer.h"
#import "Utilities.h"
#import "CellData.h"

@implementation OptionRenderer

-(void) redraw
{
    [choiceRenderList removeAllObjects];
    
    //This may actually result in two renderers being created for each item.
    //This may be a problem. We'll see.
    for (Choice *currentChoice in optionInfo.choiceList) {
        [choiceRenderList addObject:[[ChoiceRenderer alloc] initWithChoice:currentChoice]];
    }
    
    [[suffixList objectAtIndex:0] setCellDesc:[Utilities FormatToPrice:[optionInfo totalPrice]]];
}

-(OptionRenderer *)initWithOption:(Option *)anOption
{
    optionInfo = anOption;
    displayLists = [[NSMutableArray alloc] initWithCapacity:0];
    suffixList = [[NSMutableArray alloc] initWithCapacity:0];
    
    choiceRenderList = [[NSMutableArray alloc] initWithCapacity:0];
    
    [displayLists addObject:choiceRenderList];
    [displayLists addObject:suffixList];
    
    CellData *newCell = [[CellData alloc] init];
    newCell.cellTitle = @"Total:";
    newCell.cellDesc = [Utilities FormatToPrice:[optionInfo totalPrice]];
    [suffixList addObject:newCell];
    
    return self;
}

-(UITableViewCell *)configureCell:(UITableViewCell *)aCell
{
    [[aCell detailTextLabel] setText:[Utilities FormatToPrice:optionInfo.totalPrice]];
    [[aCell textLabel] setText:optionInfo.name];
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
