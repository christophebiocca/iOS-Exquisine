//
//  ItemGroupType1.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-07.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemGroupMultiplicativePricing.h"
#import "Item.h"

@implementation ItemGroupMultiplicativePricing
-(id)initWithData:(NSDictionary *)inputData
{
    if(self = [super init])
    {
        NSInteger percent = [[inputData objectForKey:@"factor_percent"] intValue];
        multiplicativeValue = [[[NSDecimalNumber alloc] initWithInteger:percent] decimalNumberByMultiplyingByPowerOf10:-2];
    }
    return self;
}

-(void) multiplicativeValueRecovery:(NSCoder *)decoder
{
    switch (harddiskDataVersion) {
        case VERSION_0_0_0:
            //fall through to next
        case VERSION_1_0_0:
            //fall through to next
        case VERSION_1_0_1:
            multiplicativeValue = [decoder decodeObjectForKey:@"multiplicative_value"];
        case VERSION_1_1_0:
            break;
        default:
            break;
    }
}

-(NSDecimalNumber *)priceForItem:(Item *)item
{
    return [[item price] decimalNumberByMultiplyingBy:multiplicativeValue];
}

-(Item*)optimalItem:(NSArray*)items{
    // The biggest savings comes from picking the most expensive item.
    Item* maxItem = nil;
    NSDecimalNumber* maxPrice = [NSDecimalNumber minimumDecimalNumber];
    for(Item* item in items){
        NSDecimalNumber* price = [item price];
        if([price compare:maxPrice] == NSOrderedDescending){
            maxPrice = price;
            maxItem = item;
        }
    }
    return maxItem;
}

-(NSString *)description
{
    return @"Group multiplicative pricing strategy";
}

@end
