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
@protocol ItemGroupPricingStrategy;

//An item group is simply a collection of items and menus that provides
//a check to see whether an item is within the group.

extern NSString* ITEM_GROUP_MODIFIED;

@interface ItemGroup : MenuComponent
{
    
    NSMutableArray *listOfItems;
    Item *satisfyingItem;
    NSMutableArray *satisfyingMenus;
    
    id<ItemGroupPricingStrategy> strategy;
    
    // Temporary, cached values
    NSSet* itemIds;
}

@property (retain,readonly) NSMutableArray *listOfItems;
@property (retain,readonly) NSSet *itemIds;
@property (retain,readonly) NSMutableArray *satisfyingMenus;
@property (retain,nonatomic) Item *satisfyingItem;
@property (readonly) BOOL satisfied;

//Initializers

-(ItemGroup *)initWithDataAndParentMenu:(NSDictionary *)inputData:(Menu *) parentMenu;

-(ItemGroup *) copy;

-(ItemGroup *)optimalPickFromItems:(NSArray*)items;

//Access Methods
- (BOOL) containsItem: (Item *) anItem;

- (NSDecimalNumber *) price;
- (NSDecimalNumber *) savings;

//Mutation Methods
- (void) addItem: (Item *) anItem;

- (void) addListOfItems: (NSArray *) items;

- (void) addMenu: (Menu *) aMenu;

//Housekeeping Methods

//Comparitor and Descriptor Methods
- (NSString *) descriptionWithIndent:(NSInteger) indentLevel;

-(NSDictionary*)orderRepresentation;

@end
