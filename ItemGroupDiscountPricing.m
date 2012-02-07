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

-(ItemGroup *)initWithDataAndParentMenu:(NSDictionary *)inputData :(Menu *)parentMenu
{
    
    if(self = [super initWithDataAndParentMenu:inputData :parentMenu])
    {
        NSInteger cents = [[inputData objectForKey:@"discount_value"] intValue];
        discountValue = [[[NSDecimalNumber alloc] initWithInteger:cents] decimalNumberByMultiplyingByPowerOf10:-2];
    }
    
    return self;
}

-(NSDecimalNumber *)price
{
    return [[satisfyingItem price] decimalNumberBySubtracting:discountValue];
}

@end
