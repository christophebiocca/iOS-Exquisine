//
//  ItemGroupAbsolutePricing.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-07.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemGroupPricingStrategy.h"

@interface ItemGroupAbsolutePricing : NSObject<ItemGroupPricingStrategy>
{
    NSDecimalNumber *absoluteValue;
}

@end
