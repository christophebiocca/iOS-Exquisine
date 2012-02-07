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
    self = [super initWithMenuComponent:anItem];
    
    itemInfo = anItem;
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return ([[itemInfo options] count]);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    [newCell setCellDesc:[Utilities FormatToPrice:[itemInfo price]]];
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
