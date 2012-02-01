//
//  MenuRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuRenderer.h"
#import "Menu.h"
#import "Item.h"
#import "MenuCell.h"
#import "ItemMenuCell.h"
#import "Combo.h"
#import "ComboCell.h"

@implementation MenuRenderer

-(MenuRenderer *)initWithMenu:(Menu *)aMenu
{
    self = [super init];
    
    menuInfo = aMenu;
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ([[menuInfo submenuList] count] + [[menuInfo comboList] count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray *displayList = [[NSMutableArray alloc] initWithArray:[menuInfo submenuList]];
    
    [displayList addObjectsFromArray:[menuInfo comboList]];
    
    id thingToDisplay = [displayList objectAtIndex:[indexPath row]];
    
    if ([thingToDisplay isKindOfClass:[Item class]]) {
        
        ItemMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:[ItemMenuCell cellIdentifier]];
        
        if (cell == nil)
        {
            cell = [[ItemMenuCell alloc] init];
        }
        
        [cell setItem:thingToDisplay];
        
        return cell;
        
    }
    
    if ([thingToDisplay isKindOfClass:[Menu class]]) {
        
        MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:[MenuCell cellIdentifier]];
        
        if (cell == nil)
        {
            cell = [[MenuCell alloc] init];
        }
        
        [cell setMenu:thingToDisplay];
        
        return cell;
    }
    
    if ([thingToDisplay isKindOfClass:[Combo class]]) {
        
        ComboCell *cell = [tableView dequeueReusableCellWithIdentifier:[ComboCell cellIdentifier]];
        
        if (cell == nil)
        {
            cell = [[ComboCell alloc] init];
        }
        
        [cell setCombo:thingToDisplay];
        [cell setStyle:@"fancy"];
        
        return cell;
    }
    
    return nil;
}


@end
