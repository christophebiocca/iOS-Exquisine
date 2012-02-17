//
//  ItemGroupRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-01.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemGroupRenderer.h"
#import "Item.h"
#import "ItemGroup.h"
#import "ItemMenuCell.h"

@implementation ItemGroupRenderer

-(ItemGroupRenderer *)initFromItemGroup:(ItemGroup *)anItemGroup
{
    self = [super init];
    
    currentItemGroup = anItemGroup;
    
    return self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    Item *thingToDisplay = [[currentItemGroup listOfItems]  objectAtIndex:[indexPath row]];
    
    ItemMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:[ItemMenuCell cellIdentifier]];
    
    if (cell == nil)
    {
        cell = [[ItemMenuCell alloc] init];
    }
    
    [cell setMenuComponent:thingToDisplay];
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[currentItemGroup listOfItems] count];
}

@end
