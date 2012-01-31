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
        
        NSMutableArray *newItemList = [[NSMutableArray alloc] initWithCapacity:0];
        
        NSMutableArray *itemPKs = [componentInfo objectForKey:@"items"];
        NSMutableArray *menuPKs = [componentInfo objectForKey:@"menus"];
        
        for (NSString *itemPK in itemPKs) 
        {
            NSInteger intItemPK = [itemPK intValue];
            Item *itemToAdd = [associatedMenu dereferenceItemPK:intItemPK];
            [newItemList addObject:itemToAdd];
        }
        
        for (NSString *menuPK in menuPKs)
        {
            Menu *menuForPK = [associatedMenu dereferenceMenuPK:[menuPK intValue]];
            [newItemList addObjectsFromArray:[menuForPK flatItemList]];
        }
        
        [listOfItemGroups addObject:newItemList];
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
    
    for (NSMutableArray *itemGroup in listOfItemGroups) 
    {
        BOOL qualifies = NO;
        for (Item *comboItem in itemGroup)
        {
            for (Item *anItem in mutableOrder.itemList) {
                if ([anItem.name isEqual:comboItem.name]) {
                    qualifies = YES;
                    //To make sure we don't double-count.
                    [listOfAssociatedItems addObject:anItem];
                    [mutableOrder.itemList removeObject:anItem];
                    break;
                }
                
            }
        }
        if (!qualifies)
        {
            return NO;
        }
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

-(NSString *)description
{
    NSMutableString *output = [[NSMutableString alloc] initWithCapacity:0];
    [output appendFormat:@"Combo Name: %@\n", name];
    int i = 1;
    for (NSMutableArray *itemList in listOfItemGroups) {
        [output appendFormat:@"    Item Group %i\n",i];
        for (Item *anItem in itemList) {
            [output appendFormat:@"        Name of item: %@\n",[anItem name]];
        }
        i++;
    }
    
    return output;
}

@end
