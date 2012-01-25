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

@synthesize submenuList;

-(Menu *)init
{
    submenuList = [[NSMutableArray alloc] initWithCapacity:0];
    return self;
}

-(Menu *) initFromData:(NSDictionary *)inputData
{
    self = [super initFromData:inputData];
    
    submenuList = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSDictionary *submenu in [inputData objectForKey:@"submenus"]) {
        Menu *newSubmenu = [[Menu alloc] initFromData:submenu];
        [submenuList addObject:newSubmenu];
    }
    
    for (NSDictionary *item in [inputData objectForKey:@"items"]) {
        Item *newItem = [[Item alloc] initFromData:item];
        [submenuList addObject:newItem];
    }
    
    for (NSDictionary *combo in [inputData objectForKey:@"combos"]) {
        Combo *newCombo = [[Combo alloc] initFromData:combo];
        [comboList addObject:newCombo];
    }
    
    return self;
    
}

-(void)addSubmenu:(Menu *)aSubmenu
{
    [submenuList addObject:aSubmenu];
}

@end
