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
    if (![[itemInfo desc] isEqualToString:@""]) {
        return ([[itemInfo options] count] + 1);
    }
    return ([[itemInfo options] count]);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(![[itemInfo desc] isEqualToString:@""])
    {
        if (section == 0) 
        {
            return 1;
        }
        else
        {
            return [[[[itemInfo options] objectAtIndex:(section - 1)] choiceList] count];
        }
    }
    return [[[[itemInfo options] objectAtIndex:section] choiceList] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![[itemInfo desc] isEqualToString:@""])
    {
        if([indexPath section] == 0)
        {
            ChoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (cell == nil) {
                cell = [[ChoiceCell alloc] init];
            }
            [[cell textLabel] setText:[itemInfo desc]];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
        else
        {
            ChoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:[ChoiceCell cellIdentifier]];
            if (cell == nil) {
                cell = [[ChoiceCell alloc] init];
            }
            
            Option *thisOption = [[itemInfo options] objectAtIndex:([indexPath section] - 1)];
            Choice *thisChoice = [[thisOption choiceList] objectAtIndex:[indexPath row]];
            [cell setMenuComponent:thisChoice];    
            
            return cell;
        }
    }
    
    Option *thisOption = [[itemInfo options] objectAtIndex:[indexPath section]];
    MenuComponent *thisChoice = [[thisOption choiceList] objectAtIndex:[indexPath row]];
    
    MenuCompositeCell *cell = [tableView dequeueReusableCellWithIdentifier:[MenuCompositeCell cellIdentifierForMenuComponent:thisChoice AndContext:VIEW_CELL_CONTEXT_MENU]];
    
    if (cell == nil) {
        cell = [MenuCompositeCell customViewCellWithMenuComponent:thisChoice AndContext:VIEW_CELL_CONTEXT_MENU];
    }
    else
    {
        [cell setMenuComponent:thisChoice];
    }
    
    return cell;

}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (![[itemInfo desc] isEqualToString:@""]) {
        if(section == 0)
            return @"Description";
        return [[[itemInfo options] objectAtIndex:(section - 1)] name];
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
