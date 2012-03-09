//
//  ItemGroupDiscountPricing.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-07.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemGroupPricingStrategy.h"
#import "AutomagicalCoder.h"

@interface ItemGroupDiscountPricing : AutomagicalCoder<ItemGroupPricingStrategy>
{
    NSDecimalNumber *discountValue;
}

-(id)initWithData:(NSDictionary*)inputData;

@end
