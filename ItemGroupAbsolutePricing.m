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

-(ItemGroup *)initWithDataAndParentMenu:(NSDictionary *)inputData :(Menu *)parentMenu
{
    
    if(self = [super initWithDataAndParentMenu:inputData :parentMenu])
    {
        NSInteger cents = [[inputData objectForKey:@"absolute_value"] intValue];
        absoluteValue = [[[NSDecimalNumber alloc] initWithInteger:cents] decimalNumberByMultiplyingByPowerOf10:-2];
    }
    
    return self;
}

-(NSDecimalNumber *)price
{
    return absoluteValue;
}
@end
