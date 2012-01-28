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
#import "ChoiceCell.h"
#import "Utilities.h"

@implementation ItemRenderer

@synthesize itemInfo;

-(ItemRenderer *)initWithItem:(Item *)anItem
{
    itemInfo = anItem;
    
    CellData *aCell = nil;
    
    suffixList = [[NSMutableArray alloc] initWithCapacity:0];
    
    if([itemInfo.options count] == 0)
    {
        aCell = [[CellData alloc] init];
        [aCell setCellTitleFontSize:17];
        [aCell setCellDescFontSize:17];
        [aCell setCellTitleFontType:@"Noteworthy-Bold"];
        [aCell setCellDescFontType:@"Noteworthy-Light"];
        aCell.cellTitle = @"No Options";
        aCell.cellDesc = @"";
        [suffixList addObject:aCell];
    }
    
    aCell = [[CellData alloc] init];
    [aCell setCellTitleFontSize:17];
    [aCell setCellDescFontSize:17];
    [aCell setCellTitleFontType:@"Noteworthy-Bold"];
    [aCell setCellDescFontType:@"Noteworthy-Light"];
    aCell.cellTitle = @"Base Price: ";
    aCell.cellDesc = [Utilities FormatToPrice:[itemInfo basePrice]];
    [suffixList addObject:aCell];
    
    aCell = [[CellData alloc] init];
    [aCell setCellTitleFontSize:17];
    [aCell setCellDescFontSize:17];
    [aCell setCellTitleFontType:@"Noteworthy-Bold"];
    [aCell setCellDescFontType:@"Noteworthy-Light"];
    aCell.cellTitle = @"Total Item Price:";
    aCell.cellDesc = [Utilities FormatToPrice:[itemInfo totalPrice]];
    [suffixList addObject:aCell];
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return (1 + [[itemInfo options] count]);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == [[itemInfo options] count]) {
        return [suffixList count];
    }
    return [[[[itemInfo options] objectAtIndex:section] choiceList] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([indexPath section] == [[itemInfo options] count]) 
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        
        [[suffixList objectAtIndex:[indexPath row]] configureCell:cell];
        
        return cell;
    }
    
    ChoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:[ChoiceCell cellIdentifier]];
    if (cell == nil) {
        cell = [[ChoiceCell alloc] init];
    }
    
    Option *thisOption = [[itemInfo options] objectAtIndex:[indexPath section]];
    Choice *thisChoice = [[thisOption choiceList] objectAtIndex:[indexPath row]];
    [cell setChoice:thisChoice];    
    
    return cell;

}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == [[itemInfo options] count]) {
        return @"Price";
    }
    return [[[itemInfo options] objectAtIndex:section] name];
}

-(NSArray *)detailedStaticRenderList
{
    NSMutableArray *returnList = [[NSMutableArray alloc] initWithCapacity:0];
    
    CellData *newCell = [super detailedStaticRenderDefaultCell];
    [newCell setCellDesc:[Utilities FormatToPrice:[itemInfo totalPrice]]];
    [newCell setCellTitle:[itemInfo name]];
    
    [returnList addObject:newCell];
    
    for (Option *anOption in [itemInfo options]) {
        OptionRenderer *optionRenderer = [[OptionRenderer alloc] initWithOption:anOption];
        
        for (CellData *aCell in [optionRenderer detailedStaticRenderList]) {
            [aCell tab];
            [aCell setCellDesc:@""];
            [returnList addObject:aCell];
        }
        
    }
    
    return returnList;
}


@end
