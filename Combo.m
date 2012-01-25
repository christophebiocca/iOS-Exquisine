//
//  Combo.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Combo.h"
#import "Item.h"

@implementation Combo


-(Combo *)initFromData:(NSDictionary *)inputData
{
    self = [super initFromData:inputData];
    
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

@end
