//
//  ItemGroupPricingStrategy.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-07.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemGroupPricingStrategy.h"

#import "ItemGroupMultiplicativePricing.h"
#import "ItemGroupDiscountPricing.h"
#import "ItemGroupAbsolutePricing.h"
#import "ItemGroupTrivialPricing.h"

@implementation ItemGroupPricingStrategy

//See [self initialize]
static NSDictionary* itemGroupClassDictionary = nil;

+(void)initialize{
    if(!itemGroupClassDictionary){
        itemGroupClassDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [ItemGroupTrivialPricing class], @"Trivial",
                                    [ItemGroupAbsolutePricing class], @"Absolute",
                                    [ItemGroupDiscountPricing class], @"Discount",
                                    [ItemGroupMultiplicativePricing class], @"Multiplicative",
                                    nil];
    }
}

+(id<ItemGroupPricingStrategy>)pricingStrategyFromData:(NSDictionary*)data{
    return [(id<ItemGroupPricingStrategy>)[[itemGroupClassDictionary 
                                            objectForKey:[data objectForKey:@"name"]] alloc] 
            initWithData:data];
}

@end
