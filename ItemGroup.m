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

-(ItemGroup *)init
{
    self = [super init];
    
    listOfItems = [[NSMutableArray alloc] initWithCapacity:0];
    
    return self;
}

-(ItemGroup *)initWithDataAndParentMenu:(NSDictionary *)inputData :(Menu *)parentMenu
{
    self = [super initFromData:inputData];
    
    listOfItems = [[NSMutableArray alloc] initWithCapacity:0];
    
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
            [listOfItems addObject:itemToAdd];
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
            [listOfItems addObjectsFromArray:[menuForPK flatItemList]];
        }
        else
        {
            CLLog(LOG_LEVEL_ERROR, [NSString stringWithFormat: @"A dereference was attempted on an invalid menu PK %@\n%@",menuPK,parentMenu]);
        }
    }
    
    return self;
    
}

- (MenuComponent *)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        listOfItems = [decoder decodeObjectForKey:@"list_of_items"];
        satisfyingItem = [decoder decodeObjectForKey:@"satisfying_item"];
        strategy = [decoder decodeObjectForKey:@"strategy"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Rinse and repeat this:
    [super encodeWithCoder:encoder];    
    [encoder encodeObject:listOfItems forKey:@"list_of_items"];
    [encoder encodeObject:satisfyingItem forKey:@"satisfying_item"];
    [encoder encodeObject:strategy forKey:@"strategy"];
}

-(ItemGroup *)copy
{
    ItemGroup *anItemGroup = [[ItemGroup alloc] init];
    
    anItemGroup->listOfItems = [[NSMutableArray alloc] initWithArray:listOfItems];
    
    anItemGroup->satisfyingItem = [satisfyingItem copy];
    
    anItemGroup->strategy = strategy;
    
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
    if(!satisfyingItem) return nil;
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
    [listOfItems addObject:anItem];
    itemIds = nil;
}

-(void) addListOfItems:(NSArray *)items
{
    [listOfItems addObjectsFromArray:items];
    itemIds = nil;
}

-(void)addMenu:(Menu *)aMenu
{
    [listOfItems addObjectsFromArray:[aMenu flatItemList]];
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

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
