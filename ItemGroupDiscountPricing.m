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

-(void) discountValueRecovery:(NSCoder *)decoder
{
    switch (harddiskDataVersion) {
        case VERSION_0_0_0:
            //fall through to next
        case VERSION_1_0_0:
            //fall through to next
        case VERSION_1_0_1:
            discountValue = [decoder decodeObjectForKey:@"discount_value"];
        case VERSION_1_1_0:
            break;
        default:
            break;
    }
}

-(NSDecimalNumber*)priceForItem:(Item*)item
{
    return [[item price] decimalNumberBySubtracting:discountValue];
}

-(Item*)optimalItem:(NSArray*)items{
    return [items lastObject];
}

-(NSString *)description
{
    return @"Group discount pricing strategy";
}

@end
