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
    satisfyingItem = [[Item alloc] init];
    
    return self;
}

-(ItemGroup *)initWithDataAndParentMenu:(NSDictionary *)inputData :(Menu *)parentMenu
{
    self = [super initFromData:inputData];
    
    listOfItems = [[NSMutableArray alloc] initWithCapacity:0];
    
    strategy = [ItemGroupPricingStrategy pricingStrategyFromData:[inputData objectForKey:@"pricing_strategy"]];
        
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
            NSLog(@"ERROR: A dereference was attempted on an invalid item PK %i\n%@",intItemPK,parentMenu);
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
            NSLog(@"ERROR: A dereference was attempted on an invalid menu PK %@\n%@",menuPK,parentMenu);
        }
    }
    
    satisfyingItem = [[Item alloc] init];
    
    return self;
    
}

- (MenuComponent *)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        listOfItems = [decoder decodeObjectForKey:@"list_of_items"];
        satisfyingItem = [decoder decodeObjectForKey:@"satisfying_item"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Rinse and repeat this:
    [super encodeWithCoder:encoder];    
    [encoder encodeObject:listOfItems forKey:@"list_of_items"];
    [encoder encodeObject:listOfItems forKey:@"satisfying_item"];
}

-(ItemGroup *)copy
{
    ItemGroup *anItemGroup = [[ItemGroup alloc] init];
    
    anItemGroup->listOfItems = [[NSMutableArray alloc] initWithArray:listOfItems];
    
    anItemGroup->satisfyingItem = [satisfyingItem copy];
    
    return anItemGroup;
    
}

-(BOOL)containsItem:(Item *)anItem
{
    for (Item *item in listOfItems) {
        if ([anItem.name isEqualToString:item.name]) {
            return YES;
        }
    }
    return NO;
}

-(BOOL)satisfied
{
    return [self containsItem:satisfyingItem];
}

-(NSDecimalNumber *)price
{
    return [strategy priceForItem:satisfyingItem];
}

-(void)setSatisfyingItem:(Item *)anItem
{
    satisfyingItem = anItem;
    [[NSNotificationCenter defaultCenter] postNotificationName:ITEM_GROUP_MODIFIED object:self];
}

-(void)addItem:(Item *)anItem
{
    [listOfItems addObject:anItem];
}

-(void) addListOfItems:(NSArray *)items
{
    [listOfItems addObjectsFromArray:items];
}

-(void)addMenu:(Menu *)aMenu
{
    [listOfItems addObjectsFromArray:[aMenu flatItemList]];
}

- (NSString *) descriptionWithIndent:(NSInteger) indentLevel
{    
    NSString *padString = [@"" stringByPaddingToLength:(indentLevel*4) withString:@" " startingAtIndex:0];
    
    NSMutableString *output = [[NSMutableString alloc] initWithCapacity:0];
    
    [output appendFormat:@"%@ItemGroup:%\n",padString];
    [output appendString:[super descriptionWithIndent:indentLevel]];
    [output appendFormat:@"%@Satisfied: %i\n",padString,[self satisfied]];
    [output appendFormat:@"%@Satisfying item: %@\n",padString,satisfyingItem];
    [output appendFormat:@"%@Items:\n",padString];
    
    for (Item *anItem in listOfItems) {
        [output appendFormat:@"%@\n",[anItem descriptionWithIndent:(indentLevel + 1)]];
    }
    
    return output;
}




@end
