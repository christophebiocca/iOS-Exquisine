//
//  ItemGroupAbsolutePricing.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-07.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemGroupAbsolutePricing.h"
#import "Item.h"

@implementation ItemGroupAbsolutePricing

-(id)initWithData:(NSDictionary*)inputData
{
    if(self = [super init])
    {
        NSInteger cents = [[inputData objectForKey:@"price_cents"] intValue];
        absoluteValue = [[[NSDecimalNumber alloc] initWithInteger:cents] decimalNumberByMultiplyingByPowerOf10:-2];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    absoluteValue = [aDecoder decodeObjectForKey:@"absolute_value"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:absoluteValue forKey:@"absolute_value"];
}

-(NSDecimalNumber*)priceForItem:(Item*)item
{
    return absoluteValue;
}
@end
