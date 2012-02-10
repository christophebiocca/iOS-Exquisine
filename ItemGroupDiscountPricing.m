//
//  ItemGroupDiscountPricing.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-07.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemGroupDiscountPricing.h"
#import "Item.h"

@implementation ItemGroupDiscountPricing

-(id)initWithData:(NSDictionary*)inputData
{
    if(self = [super init])
    {
        NSInteger cents = [[inputData objectForKey:@"discount_cents"] intValue];
        discountValue = [[[NSDecimalNumber alloc] initWithInteger:cents] decimalNumberByMultiplyingByPowerOf10:-2];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    discountValue = [aDecoder decodeObjectForKey:@"discount_value"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:discountValue forKey:@"discount_value"];
}

-(NSDecimalNumber*)priceForItem:(Item*)item
{
    return [[item price] decimalNumberBySubtracting:discountValue];
}

@end