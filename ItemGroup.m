//
//  ItemGroup.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-31.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemGroup.h"
#import "Menu.h"
#import "Item.h"
#import "Order.h"
#import "Combo.h"
#import "ItemGroupPricingStrategy.h"

NSString* ITEM_GROUP_MODIFIED = @"CroutonLabs/ItemGroupModified";

@implementation ItemGroup

@synthesize listOfItems;
@synthesize satisfyingItem;
@synthesize satisfyingMenus;

-(ItemGroup *)init
{
    self = [super init];
    
    listOfItems = [[NSMutableArray alloc] initWithCapacity:0];
    satisfyingMenus = [[NSMutableArray alloc] initWithCapacity:0];
    //This menu will contain all of the items that satisfy an item group that are not
    //accounted for in the other explicitly added menus.
    Menu *otherMenu = [[Menu alloc] init];
    [otherMenu setName:@"Other"];
    [satisfyingMenus addObject:otherMenu];
    
    return self;
}

-(ItemGroup *)initWithDataAndParentMenu:(NSDictionary *)inputData :(Menu *)parentMenu
{
    self = [super initFromData:inputData];
    
    listOfItems = [[NSMutableArray alloc] initWithCapacity:0];
    satisfyingMenus = [[NSMutableArray alloc] initWithCapacity:0];
    Menu *otherMenu = [[Menu alloc] init];
    [otherMenu setName:@"Other"];
    [satisfyingMenus addObject:otherMenu];
    
    strategy = [ItemGroupPricingStrategy pricingStrategyFromData:[inputData objectForKey:@"pricing_strategy"]];
        
    if(!strategy)
    {
        CLLog(LOG_LEVEL_ERROR, @"An invalid ItemStrategy string was parsed from JSON data");
    }
    
    NSMutableArray *itemPKs = [inputData objectForKey:@"items"];
    NSMutableArray *menuPKs = [inputData objectForKey:@"menus"] ;
    
    for (NSString *itemPK in itemPKs) 
    {
        NSInteger intItemPK = [itemPK intValue];
        Item *itemToAdd = [parentMenu dereferenceItemPK:intItemPK];
        if (itemToAdd) {
            [self addItem:itemToAdd];
        }
        else
        {
            CLLog(LOG_LEVEL_ERROR, [NSString stringWithFormat: @"A dereference was attempted on an invalid item PK %i\n%@",intItemPK,parentMenu]);
        }
        
    }
    
    for (NSString *menuPK in menuPKs)
    {
        Menu *menuForPK = [parentMenu dereferenceMenuPK:[menuPK intValue]];
        if (menuForPK) {
            [self addMenu:menuForPK];
        }
        else
        {
            CLLog(LOG_LEVEL_ERROR, [NSString stringWithFormat: @"A dereference was attempted on an invalid menu PK %@\n%@",menuPK,parentMenu]);
        }
    }
    
    return self;
    
}

-(void) listOfItemsRecovery:(NSCoder *)decoder
{
    switch (harddiskDataVersion) {
        case VERSION_0_0_0:
            //fall through to next
        case VERSION_1_0_0:
            //fall through to next
        case VERSION_1_0_1:
            listOfItems = [decoder decodeObjectForKey:@"list_of_items"];
        case VERSION_1_1_0:
            break;
        default:
            break;
    }
}

-(void) satisfyingItemRecovery:(NSCoder *)decoder
{
    switch (harddiskDataVersion) {
        case VERSION_0_0_0:
            //fall through to next
        case VERSION_1_0_0:
            //fall through to next
        case VERSION_1_0_1:
            satisfyingItem = [decoder decodeObjectForKey:@"satisfying_item"];
        case VERSION_1_1_0:
            break;
        default:
            break;
    }
}

-(ItemGroup *)copy
{
    
    ItemGroup *anItemGroup = [[ItemGroup alloc] init];
    
    anItemGroup->primaryKey = primaryKey;
    
    anItemGroup->name = name;
    
    anItemGroup->desc = desc;
    
    anItemGroup->listOfItems = [[NSMutableArray alloc] initWithArray:listOfItems];
    
    anItemGroup->satisfyingItem = [satisfyingItem copy];
    
    anItemGroup->strategy = strategy;
    
    anItemGroup->satisfyingMenus = [[NSMutableArray alloc] initWithArray:satisfyingMenus];
    
    return anItemGroup;
    
}

-(BOOL)containsItem:(Item *)anItem
{
    return [[self itemIds] containsObject:[NSNumber numberWithUnsignedInteger:[anItem primaryKey]]];
}

-(BOOL)satisfied
{
    return satisfyingItem && [self containsItem:satisfyingItem];
}

-(NSDecimalNumber *)price
{
    if(!satisfyingItem) return [NSDecimalNumber decimalNumberWithString:@"0"];
    return [strategy priceForItem:satisfyingItem];
}

-(NSDecimalNumber *)savings
{
    if(!satisfyingItem) return nil;
    return [[[self satisfyingItem] price] decimalNumberBySubtracting:[self price]];
}

-(void)setSatisfyingItem:(Item *)anItem
{
    if(satisfyingItem)
        [[NSNotificationCenter defaultCenter] removeObserver:self name:ITEM_MODIFIED object:satisfyingItem];
    satisfyingItem = anItem;
    [[NSNotificationCenter defaultCenter] postNotificationName:ITEM_GROUP_MODIFIED object:self];
}

-(void)addItem:(Item *)anItem
{
    BOOL itemInMenus = NO;
    for (Menu *eachMenu in satisfyingMenus) {
        if ([[eachMenu flatItemList] containsObject:anItem]) {
            itemInMenus = YES;
        }
    }
    if (!itemInMenus) {
        //Add the item to the "other" menu.
        [[satisfyingMenus objectAtIndex:0] addItem:anItem];
    }
    [listOfItems addObject:anItem];
    itemIds = nil;
}

-(void) addListOfItems:(NSArray *)items
{
    for (Item *eachItem in items) {
        [self addItem:eachItem];
    }
}

-(void)addMenu:(Menu *)aMenu
{
    [satisfyingMenus addObject:aMenu];
    [self addListOfItems:[aMenu flatItemList]];
    itemIds = nil;
}

-(NSSet*)itemIds{
    if(!itemIds){
        NSMutableSet* ids = [NSMutableSet setWithCapacity:[listOfItems count]];
        for(Item* item in listOfItems){
            [ids addObject:[NSNumber numberWithUnsignedInteger:[item primaryKey]]];
        }
        itemIds = ids;
    }
    return itemIds;
}

- (NSString *) descriptionWithIndent:(NSInteger) indentLevel
{    
    NSString *padString = [@"" stringByPaddingToLength:(indentLevel*4) withString:@" " startingAtIndex:0];
    
    NSMutableString *output = [[NSMutableString alloc] initWithCapacity:0];
    
    [output appendFormat:@"%@ItemGroup:%\n",padString];
    [output appendString:[super descriptionWithIndent:indentLevel]];
    [output appendFormat:@"%@Pricing strategy: %@\n",padString,strategy];
    [output appendFormat:@"%@Satisfied: %i\n",padString,[self satisfied]];
    [output appendFormat:@"%@Satisfying item: %@\n",padString,[satisfyingItem descriptionWithIndent:(indentLevel + 1)]];
    [output appendFormat:@"%@Items:\n",padString];
    
    for (Item *anItem in listOfItems) {
        [output appendFormat:@"%@\n",[anItem descriptionWithIndent:(indentLevel + 1)]];
    }
    
    return output;
}

-(ItemGroup*)optimalPickFromItems:(NSArray *)items{
    NSSet* ids = [self itemIds];
    NSArray* applicable = [items filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(Item* item, NSDictionary *bindings) {
        return [ids containsObject:[NSNumber numberWithUnsignedInteger:[item primaryKey]]];
    }]];
    if(![applicable count]){
        return nil;
    }
    ItemGroup* new = [self copy];
    [new setSatisfyingItem:[strategy optimalItem:applicable]];
    return new;
}

-(NSDictionary*)orderRepresentation{
    NSMutableDictionary* itemDictionary = 
    [NSMutableDictionary dictionaryWithDictionary:[satisfyingItem orderRepresentation]];
    [itemDictionary setObject:[NSNumber numberWithUnsignedInteger:primaryKey] forKey:@"component"];
    return itemDictionary;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
