//
//  Menu.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Menu.h"
#import "Item.h"
#import "Combo.h"

@implementation Menu

@synthesize submenuList, comboList;

-(Menu *)init
{
    parentMenu = nil;
    submenuList = [[NSMutableArray alloc] initWithCapacity:0];
    return self;
}

-(Menu *) initFromData:(NSDictionary *)inputData
{
    self = [super initFromData:inputData];
    parentMenu = nil;
    
    submenuList = [[NSMutableArray alloc] initWithCapacity:0];
    comboList = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSDictionary *submenu in [inputData objectForKey:@"submenus"]) {
        Menu *newSubmenu = [[Menu alloc] initFromDataAndMenu:submenu:self];
        [submenuList addObject:newSubmenu];
    }
    
    for (NSDictionary *item in [inputData objectForKey:@"items"]) {
        Item *newItem = [[Item alloc] initFromData:item];
        [submenuList addObject:newItem];
    }
    
    for (NSDictionary *combo in [inputData objectForKey:@"combos"]) {
        Combo *newCombo = [[Combo alloc] initFromDataAndMenu:combo :self];
        [comboList addObject:newCombo];
    }
    
    return self;
    
}

-(Menu *) initFromDataAndMenu:(NSDictionary *)inputData:(Menu *) inputMenu
{
    self = [super initFromData:inputData];
    parentMenu = inputMenu;
    submenuList = [[NSMutableArray alloc] initWithCapacity:0];
    comboList = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSDictionary *submenu in [inputData objectForKey:@"submenus"]) {
        Menu *newSubmenu = [[Menu alloc] initFromDataAndMenu:submenu :parentMenu];
        [submenuList addObject:newSubmenu];
    }
    
    for (NSDictionary *item in [inputData objectForKey:@"items"]) {
        Item *newItem = [[Item alloc] initFromData:item];
        [submenuList addObject:newItem];
    }
    
    for (NSDictionary *combo in [inputData objectForKey:@"combos"]) {
        Combo *newCombo = [[Combo alloc] initFromDataAndMenu:combo :parentMenu];
        [comboList addObject:newCombo];
    }
    
    return self;
    
}

-(void)addSubmenu:(Menu *)aSubmenu
{
    [submenuList addObject:aSubmenu];
}

-(Item *)dereferenceItemPK:(NSInteger)itemPK
{
    for (id possibleContainers in submenuList) {
        if([possibleContainers isKindOfClass:[Item class]])
        {
            if([possibleContainers primaryKey] == itemPK)
                return possibleContainers;
        }
        if([possibleContainers isKindOfClass:[Menu class]])
        {
            Item *maybeTheItem = [possibleContainers dereferenceItemPK:itemPK];
            if (maybeTheItem != nil)
                return maybeTheItem;
        }
    }
    return nil;
}

-(Menu *)dereferenceMenuPK:(NSInteger)menuPK
{
    if (primaryKey == menuPK)
        return self;
    
    for (id possibleMenus in submenuList) {
        if([possibleMenus isKindOfClass:[Menu class]])
        {
            id maybeMenu = [possibleMenus dereferenceMenuPK:menuPK];
            if (maybeMenu != nil)
            {
                return maybeMenu;
            }
        }
    }
    
    return nil;
}

-(NSArray *)flatItemList
{
    NSMutableArray *returnList = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (id possibleContainers in submenuList) {
        if([possibleContainers isKindOfClass:[Item class]])
        {
            [returnList addObject:possibleContainers];
        }
        if([possibleContainers isKindOfClass:[Menu class]])
        {
            [returnList addObjectsFromArray:[possibleContainers flatItemList]];
        }
    }
    
    return returnList;
}

- (MenuComponent *)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        submenuList = [decoder decodeObjectForKey:@"submenu_list"];
        comboList = [decoder decodeObjectForKey:@"combo_list"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Rinse and repeat this:
    [super encodeWithCoder:encoder];
    [encoder encodeObject:submenuList forKey:@"submenu_list"];
    [encoder encodeObject:comboList forKey:@"combo_list"];
}

- (NSMutableArray *) comboList
{
    NSMutableArray *output = [[NSMutableArray alloc] initWithCapacity:0];
    
    [output addObjectsFromArray:comboList];
    
    for (id aSubmenu in submenuList) {
        if ([aSubmenu isKindOfClass:[Menu class]])
        {
            [output addObjectsFromArray:[aSubmenu comboList]];
        }
    }
    return output;
}

@end
