//
//  ComboRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComboRenderer.h"
#import "Order.h"
#import "Combo.h"
#import "CellData.h"
#import "ItemRenderer.h"
#import "ItemGroup.h"
#import "ItemGroupCell.h"

@implementation ComboRenderer



-(ComboRenderer *)initFromComboAndOrder:(Combo *)aCombo :(Order *)anOrder
{
    self = [super init];
    
    currentCombo = aCombo;
    
    return self;
}


//This initializer is fine for use with produceRenderList, but it is not sufficient for
//pushing a ComboViewController. 

//I don't like that fact, we can fix it later, but that's how it is for now.
-(ComboRenderer *)initFromCombo:(Combo *)aCombo
{
    self = [super init];
    
    currentCombo = aCombo;
    
    return self;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ItemGroup *thingToDisplay = [[currentCombo listOfItemGroups] objectAtIndex:[indexPath row]];
    
    ItemGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:[ItemGroupCell cellIdentifier]];
    
    if (cell == nil)
    {
        cell = [[ItemGroupCell alloc] init];
    }
    
    [cell setItemGroup:thingToDisplay];
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[currentCombo listOfItemGroups] count];
}

//This puppy needs to return a list of things that respond to configureCell such that the group is representative
//of this combo and all involved items.
-(NSMutableArray *)produceRenderList
{
    NSMutableArray *returnList = [[NSMutableArray alloc] initWithCapacity:0];
    
    CellData *newCell = [[CellData alloc] init];
    newCell.cellTitle = currentCombo.name;
    newCell.cellDesc = [currentCombo.price stringValue];
    
    [returnList addObject:newCell];
    
    [returnList addObjectsFromArray:currentCombo.listOfAssociatedItems];
    
    return returnList;
}

-(NSMutableArray *)detailedStaticRenderList
{
    NSMutableArray *returnList = [[NSMutableArray alloc] initWithCapacity:0];
    CellData *newCell = [super detailedStaticRenderDefaultCell];
    newCell.cellTitle = currentCombo.name;
    newCell.cellDesc = [Utilities FormatToPrice:currentCombo.price];
    
    [returnList addObject:newCell];
    
    for (Item *anItem in currentCombo.listOfAssociatedItems) {
        ItemRenderer *itemRenderer = [[ItemRenderer alloc] initWithItem:anItem];
        
        for (CellData *aCell in [itemRenderer detailedStaticRenderList]) {
            [aCell tab];
            [aCell setCellDesc:@""];
            [returnList addObject:aCell];
        }
    }
    
    return returnList;
}

@end
