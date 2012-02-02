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
@class Order;
@class Combo;

//An item group is simply a collection of items and menus that provides
//a check to see whether an item is within the group.

@interface ItemGroup : MenuComponent
{
    
    Menu *parentMenu;
    Combo *parentCombo;
    NSMutableArray *listOfItems;
    
}

@property (retain) NSMutableArray *listOfItems;

-(ItemGroup *)initWithDataAndParentMenuAndParentCombo:(NSDictionary *)inputData:(Menu *) inputMenu:(Combo *)aCombo;

- (BOOL) containsItem: (Item *) anItem;

- (void) addItem: (Item *) anItem;

- (void) addListOfItems: (NSArray *) items;

- (void) addMenu: (Menu *) aMenu;

- (NSString *) descriptionWithIndent:(NSInteger) indentLevel;

-(BOOL) satisfied;

@end
