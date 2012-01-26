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

@implementation Combo

@synthesize price, listOfAssociatedItems;

-(Combo *)initFromData:(NSDictionary *)inputData
{
    self = [super initFromData:inputData];
    
    associatedOrder = nil;
    listOfAssociatedItems = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSInteger cents = [[inputData objectForKey:@"price_cents"] intValue];
    price = [[[NSDecimalNumber alloc] initWithInteger:cents] decimalNumberByMultiplyingByPowerOf10:-2];
    
    listOfItemGroups = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSDictionary *itemList in [inputData objectForKey:@"components"]) {
        
        NSMutableArray *newItemList = [[NSMutableArray alloc] initWithCapacity:0];
        
        for (NSDictionary *itemData in [itemList objectForKey:@"items"]) {
            Item *newItem = [[Item alloc] initFromData:itemData];
            [newItemList addObject:newItem];
        }
        
        [listOfItemGroups addObject:newItemList];
    }
    
    return self;
}

-(BOOL)evaluateForCombo:(Order *)anOrder
{
    associatedOrder = anOrder;
    Order *mutableOrder = [[Order alloc] initFromOrder:anOrder];
 
    [listOfAssociatedItems removeAllObjects];
    
    for (NSMutableArray *itemGroup in listOfItemGroups) 
    {
        BOOL qualifies = NO;
        for (Item *comboItem in itemGroup)
        {
            for (Item *anItem in mutableOrder.itemList) {
                if (anItem.name == comboItem.name) {
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

@end
