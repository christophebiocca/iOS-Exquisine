//
//  Combo.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Combo.h"
#import "Item.h"
#import "Order.h"
#import "Menu.h"
#import "ItemGroup.h"

NSString* COMBO_MODIFIED = @"CroutonLabs/ComboModified";


@implementation Combo

@synthesize price, listOfAssociatedItems;
@synthesize listOfItemGroups;

-(Combo *)init
{
    self = [super init];
    
    listOfItemGroups = [[NSMutableArray alloc] initWithCapacity:0];
    listOfAssociatedItems = [[NSMutableArray alloc] initWithCapacity:0];
    price = [[NSDecimalNumber alloc] initWithInt:0];
    
    return self;
}

-(Combo *)initFromDataAndMenu:(NSDictionary *)inputData:(Menu *) associatedMenu
{
    self = [super initFromData:inputData];
   
    listOfAssociatedItems = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSInteger cents = [[inputData objectForKey:@"price_cents"] intValue];
    price = [[[NSDecimalNumber alloc] initWithInteger:cents] decimalNumberByMultiplyingByPowerOf10:-2];
    
    listOfItemGroups = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSDictionary *componentInfo in [inputData objectForKey:@"components"]) {
        [listOfItemGroups addObject:[[ItemGroup alloc] initWithDataAndParentMenu:componentInfo :associatedMenu]];
    }
    
    return self;
}

- (MenuComponent *)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        
        listOfItemGroups = [decoder decodeObjectForKey:@"list_of_item_groups"];
        listOfAssociatedItems = [decoder decodeObjectForKey:@"list_of_associated_items"];
        price = [decoder decodeObjectForKey:@"price"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Rinse and repeat this:
    [super encodeWithCoder:encoder];
    [encoder encodeObject:listOfItemGroups forKey:@"list_of_item_groups"];
    [encoder encodeObject:listOfAssociatedItems forKey:@"list_of_associated_items"];
    [encoder encodeObject:price forKey:@"price"];
}

- (Combo *)copy
{
    Combo *aCombo = [[Combo alloc] init];
    
    aCombo->name = name;
    aCombo->desc = desc;
    aCombo->primaryKey = primaryKey;
    
    for (ItemGroup *anItemGroup in listOfItemGroups) {
        [[aCombo listOfItemGroups] addObject:[anItemGroup copy]];
    }
    
    for (Item *anItem in listOfAssociatedItems) {
        [[aCombo listOfAssociatedItems] addObject:[anItem copy]];
    }
    
    aCombo->price = price;
    
    return aCombo;
}

//Just placeholders****************V

-(NSArray *)satisfactionListsForItemList:(NSArray *)anItemList
{
    NSMutableArray *returnList = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (ItemGroup *anItemGroup in listOfItemGroups) {
        NSMutableArray *newSublist = [[NSMutableArray alloc] initWithCapacity:0];
        
        for (Item *eachItem in anItemList) {
            if ([anItemGroup containsItem:eachItem]) {
                [newSublist addObject:eachItem];
            }
        }
        
        [returnList addObject:newSublist];
    }
    
    return returnList;
}

-(BOOL)satisfiedWithItemList:(NSArray *)anItemList
{
    //This is pretty inefficient, but let's see if it will work. It might.
    
    NSMutableArray *helperList = [[NSMutableArray alloc] initWithArray:anItemList];
    
    for (ItemGroup *anItemGroup in listOfItemGroups) {
        [anItemGroup setSatisfied:NO];
        for (Item *anItem in [NSArray arrayWithArray: helperList]) {
            if (![anItemGroup satisfied]) {
                if ([anItemGroup containsItem:anItem]) {
                    [anItemGroup setSatisfied:YES];
                    [helperList removeObject:anItem];
                }
            }
        }
    }
    
    BOOL result = [self satisfied];
    
    [self recalculate:nil];
    
    return result;
    
}

-(BOOL)containsItem:(Item *)anItem
{
    for (Item *eachItem in listOfAssociatedItems) {
        if ([anItem isEffectivelyEqual:eachItem]) {
            return YES;
        }
    }
    return NO;
}

-(BOOL)containsExactItem:(Item *)anItem
{
    for (Item *eachItem in listOfAssociatedItems) {
        if (anItem == eachItem) {
            return YES;
        }
    }
    return NO;
}

-(BOOL)satisfied
{
    for (ItemGroup *anItemGroup in listOfItemGroups) {
        if (![anItemGroup satisfied]) {
            return NO;
        }
    }
    return YES;
}

-(NSDecimalNumber *)savingsMagnitude
{
    NSDecimalNumber *tally = [[NSDecimalNumber alloc] initWithInt:0];
    
    //This actually makes the assumption that each item in the item group costs the same price. This
    //may not be true in all cases, but I think it is for pita factory.
    for (ItemGroup *anItemGroup in listOfItemGroups) {
        [tally decimalNumberByAdding:[[[anItemGroup listOfItems] objectAtIndex:0] price]];
    }
    
    [tally decimalNumberBySubtracting:price];
    
    return tally;
}

-(void)addItem:(Item *)anItem
{
    [listOfAssociatedItems addObject:anItem];
    [self recalculate:nil];
}

-(void)removeItem:(Item *)anItem
{
    [listOfAssociatedItems removeObject:anItem];
    [self recalculate:nil];
}

-(void)removeAllItems
{
    [listOfAssociatedItems removeAllObjects];
    [self recalculate:nil];
}

-(void)recalculate:(NSNotification *)aNotification
{
    NSMutableArray *helperList = [[NSMutableArray alloc] initWithArray:listOfAssociatedItems];
    
    for (ItemGroup *anItemGroup in listOfItemGroups) {
        [anItemGroup setSatisfied:NO];
        for (Item *anItem in [NSArray arrayWithArray: helperList]) {
            if (![anItemGroup satisfied]) {
                if ([anItemGroup containsItem:anItem]) {
                    [anItemGroup setSatisfied:YES];
                    [helperList removeObject:anItem];
                }
            }
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:COMBO_MODIFIED object:self];
}

-(BOOL) isEffectivelyEqual:(Combo *) anotherCombo
{
    return ([anotherCombo.name isEqualToString:name]);
}

-(NSComparisonResult)savingsSort:(Combo *)aCombo
{
    return [[aCombo savingsMagnitude] compare:[self savingsMagnitude]];
}

-(NSString *) descriptionWithIndent:(NSInteger) indentLevel
{
    NSString *padString = [@"" stringByPaddingToLength:(indentLevel*4) withString:@" " startingAtIndex:0];
    
    NSMutableString *output = [[NSMutableString alloc] initWithCapacity:0];
    
    [output appendFormat:@"%@Combo:%\n",padString];
    [output appendString:[super descriptionWithIndent:indentLevel]];
    [output appendFormat:@"%@Price: %@\n",padString,price];
    [output appendFormat:@"%@ItemGroups:\n",padString];
    
    for (ItemGroup *anItemGroup in listOfItemGroups) {
        [output appendFormat:@"%@\n",[anItemGroup descriptionWithIndent:(indentLevel + 1)]];
    }
    
    [output appendFormat:@"%@Items:\n",padString];
    
    for (Item *anItem in listOfAssociatedItems) {
        [output appendFormat:@"%@\n",[anItem descriptionWithIndent:(indentLevel + 1)]];
    }
    
    return output;
}

@end
