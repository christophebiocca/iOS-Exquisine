//
//  ItemGroupPricingStrategy.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-07.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class Item;

@protocol ItemGroupPricingStrategy<NSObject>

-(id)initWithData:(NSDictionary*)data;
-(NSDecimalNumber*)priceForItem:(Item*)item;

@end

@interface ItemGroupPricingStrategy : NSObject

+(id<ItemGroupPricingStrategy>)pricingStrategyFromData:(NSDictionary*)data;

@end
