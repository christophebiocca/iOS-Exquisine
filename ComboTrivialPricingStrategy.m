//
//  ComboTrivialPricingStrategy.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-07.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComboTrivialPricingStrategy.h"
#import "ItemGroup.h"

@implementation ComboTrivialPricingStrategy

-(id)initWithData:(NSDictionary*)data{
    return [super init];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
   
}

-(NSDecimalNumber*)priceForItemGroups:(NSArray*)itemGroups{
    NSDecimalNumber *tally = [NSDecimalNumber zero];
    for (ItemGroup *eachItemGroup in itemGroups) {
        tally = [tally decimalNumberByAdding:[eachItemGroup price]];
    }
    return tally;
}

@end
