//
//  ItemGroup.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-31.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponent.h"

@class Menu;
@class Item;

//An item group is simply a collection of items and menus that provides
//a check to see whether an item is within the group.

@interface ItemGroup : MenuComponent
{
    
    BOOL satisfied;
    Menu *parentMenu;
    NSMutableArray *listOfItems;
    
}

@property BOOL satisfied;

-(ItemGroup *)initWithDataAndParentMenu:(NSDictionary *)inputData:(Menu *) inputMenu;

- (BOOL) containsItem: (Item *) anItem;

- (void) addItem: (Item *) anItem;

- (void) addListOfItems: (NSArray *) items;

- (void) addMenu: (Menu *) aMenu;

@end
