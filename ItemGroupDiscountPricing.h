//
//  ItemGroupDiscountPricing.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-07.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemGroupPricingStrategy.h"

@interface ItemGroupDiscountPricing : NSObject<ItemGroupPricingStrategy>
{
    NSDecimalNumber *discountValue;
}

-(id)initWithData:(NSDictionary*)inputData;

@end
