//
//  ComboPricingStrategy.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-07.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@protocol ComboPricingStrategy<NSObject, NSCoding>

-(id)initWithData:(NSDictionary*)data;
-(NSDecimalNumber*)priceForItemGroups:(NSArray*)itemGroups;
-(NSArray*)optimalPickFromItems:(NSArray*)items usingItemGroups:(NSArray*)listOfItemGroups;

@end

@interface ComboPricingStrategy : NSObject

+(id<ComboPricingStrategy>)pricingStrategyFromData:(NSDictionary*)data;

@end