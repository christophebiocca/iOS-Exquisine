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
-(ItemGroup *)initWithDataAndParentMenu:(NSDictionary *)inputData :(Menu *)parentMenu
{
    
    if(self = [super initWithDataAndParentMenu:inputData :parentMenu])
    {
        NSInteger cents = [[inputData objectForKey:@"multiplicative_value"] intValue];
        multiplicativeValue = [[[NSDecimalNumber alloc] initWithInteger:cents] decimalNumberByMultiplyingByPowerOf10:-2];
    }
    
    return self;
}

-(NSDecimalNumber *)price
{
    return [[satisfyingItem price] decimalNumberByMultiplyingBy:multiplicativeValue];
}
@end
