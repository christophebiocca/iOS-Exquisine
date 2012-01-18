//
//  Menu.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Menu.h"
#import "Item.h"

@implementation Menu

@synthesize submenuList;

-(Menu *)init
{
    submenuList = [[NSMutableArray alloc] initWithCapacity:0];
    return self;
}

-(Menu *) initFromData:(NSData *)inputData
{
    self = [super initFromData:inputData];
    
    submenuList = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSData *submenu in [inputData valueForKey:@"submenus"]) {
        Menu *newSubmenu = [[Menu alloc] initFromData:submenu];
        [submenuList addObject:newSubmenu];
    }
    for (NSData *item in [inputData valueForKey:@"items"]) {
        Item *newItem = [[Item alloc] initFromData:item];
        [submenuList addObject:newItem];
    }
    
    return self;
    
}

-(void)addSubmenu:(Menu *)aSubmenu
{
    [submenuList addObject:aSubmenu];
}

@end
