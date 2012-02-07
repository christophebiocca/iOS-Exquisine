//
//  ItemGroupType1.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-07.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemGroup.h"

@interface ItemGroupMultiplicativePricing : ItemGroup
{
    NSDecimalNumber *multiplicativeValue;
}

-(ItemGroup *)initWithDataAndParentMenu:(NSDictionary *)inputData:(Menu *) parentMenu;

-(NSDecimalNumber *)price;

@end
