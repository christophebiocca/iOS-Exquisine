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
    
    NSMutableArray *listOfItems;
    BOOL satisfied;
    
}

@property (retain,readonly) NSMutableArray *listOfItems;
@property BOOL satisfied;

//Initializers
-(ItemGroup *)initWithDataAndParentMenu:(NSDictionary *)inputData:(Menu *) parentMenu;

- (MenuComponent *)initWithCoder:(NSCoder *)decoder;

- (void)encodeWithCoder:(NSCoder *)encoder;

-(ItemGroup *) copy;

//Access Methods
- (BOOL) containsItem: (Item *) anItem;


//Mutation Methods
- (void) addItem: (Item *) anItem;

- (void) addListOfItems: (NSArray *) items;

- (void) addMenu: (Menu *) aMenu;

//Housekeeping Methods

//Comparitor and Descriptor Methods
- (NSString *) descriptionWithIndent:(NSInteger) indentLevel;

@end
