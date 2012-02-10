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

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    multiplicativeValue = [aDecoder decodeObjectForKey:@"multiplicative_value"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:multiplicativeValue forKey:@"multiplicative_value"];
}

-(NSDecimalNumber *)priceForItem:(Item *)item
{
    return [[item price] decimalNumberByMultiplyingBy:multiplicativeValue];
}
@end