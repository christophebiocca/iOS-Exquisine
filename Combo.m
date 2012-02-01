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

@implementation Combo

@synthesize price, listOfAssociatedItems;
@synthesize associatedOrder;
@synthesize listOfItemGroups;

-(Combo *)initFromDataAndMenu:(NSDictionary *)inputData:(Menu *) associatedMenu
{
    self = [super initFromData:inputData];
    
    associatedOrder = nil;
    listOfAssociatedItems = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSInteger cents = [[inputData objectForKey:@"price_cents"] intValue];
    price = [[[NSDecimalNumber alloc] initWithInteger:cents] decimalNumberByMultiplyingByPowerOf10:-2];
    
    listOfItemGroups = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSDictionary *componentInfo in [inputData objectForKey:@"components"]) {
        [listOfItemGroups addObject:[[ItemGroup alloc] initWithDataAndParentMenu:componentInfo :associatedMenu]];
    }
    
#if DEBUG
    NSLog(@"Combo Created: %@",[self description]);
#endif
    
    return self;
}

-(Combo *)initFromComboShallow:(Combo *)aCombo
{
    self = [super initFromMenuComponent:aCombo];
    
    associatedOrder = [aCombo associatedOrder];
    listOfItemGroups = [aCombo listOfItemGroups];
    listOfAssociatedItems = [[NSMutableArray alloc] initWithCapacity:0];
    for (Item *anItem in [aCombo listOfAssociatedItems]) {
        [listOfAssociatedItems addObject:anItem];
    }
    price = [[NSDecimalNumber alloc] initWithDecimal:[[aCombo price] decimalValue]];
    return self;
    
}

-(BOOL)evaluateForCombo:(Order *)anOrder
{
    associatedOrder = anOrder;
    Order *mutableOrder = [[Order alloc] initFromOrderShallow:anOrder];
 
    [listOfAssociatedItems removeAllObjects];
    
    for (ItemGroup *itemGroup in listOfItemGroups) 
    {
        BOOL qualifies = NO;
        
        for (Item *anItem in [mutableOrder itemList]) {
            if([itemGroup containsItem:anItem])
            {
                qualifies = YES;
                [listOfAssociatedItems addObject:anItem];
                [mutableOrder removeItem:anItem];
            }
        }
        
        if(!qualifies)
            return NO;
    }
    //If it actually makes it through each item group and qualifies for each, then we're good.
    return YES;
}

-(void)setOrder:(Order *)anOrder
{
    associatedOrder = anOrder;
}

//If an order qualifies for a combo, we'll want to know what items were the qualifying ones.
-(NSMutableArray *)comboItemsList
{
    if ([listOfAssociatedItems count] > 0)
    {
        return listOfAssociatedItems;
    }
    else if([self evaluateForCombo:associatedOrder])
    {
        return listOfAssociatedItems;
    }
    else
    {
        NSLog(@"Someone just requested an itemList for a bad order.");
    }
    return nil;
}

- (MenuComponent *)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        associatedOrder = [decoder decodeObjectForKey:@"associated_order"];
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
    [encoder encodeObject:associatedOrder forKey:@"associated_order"];
    [encoder encodeObject:listOfItemGroups forKey:@"list_of_item_groups"];
    [encoder encodeObject:listOfAssociatedItems forKey:@"list_of_associated_items"];
    [encoder encodeObject:price forKey:@"price"];
}

- (NSString *) descriptionWithIndent:(NSInteger) indentLevel
{
    NSMutableString *output = [NSMutableString stringWithString:[@"" stringByPaddingToLength:(indentLevel*4) withString:@" " startingAtIndex:0]];
    
    [output appendFormat:@"Combo Name: %@\n", name];
    for (ItemGroup *itemGroup in listOfItemGroups) {
        [output appendString:[itemGroup descriptionWithIndent:(indentLevel + 1)]];
    }
    return output;
}

-(NSString *)description
{
    NSMutableString *output = [[NSMutableString alloc] initWithCapacity:0];
    
    [output appendFormat:@"Combo Name: %@\n", name];
    for (ItemGroup *itemGroup in listOfItemGroups) {
        [output appendString:[itemGroup descriptionWithIndent:1]];
    }
    return output;
}

@end
