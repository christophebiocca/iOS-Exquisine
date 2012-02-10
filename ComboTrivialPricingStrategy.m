//
//  ComboTrivialPricingStrategy.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-07.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComboTrivialPricingStrategy.h"
#import "ItemGroup.h"
#import "Item.h"

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

-(NSArray*)optimalPickFromItems:(NSArray*)items usingItemGroups:(NSArray*)groups{
    if(![groups count]){
        return groups; // Which is an empty array.
    }
    NSDecimalNumber* bestSavings = [NSDecimalNumber minimumDecimalNumber];
    NSArray* bestChoice = nil;
    for(ItemGroup* group in groups){
        ItemGroup* optimal = [group optimalPickFromItems:items];
        if(!optimal){
            // Can't satisfy this item group even when it gets first pick;
            // we can guarantee that no combo using this is satisfiable.
            return nil;
        }
        NSArray* optimalRemainder;
        {
            NSMutableArray* otherGroups = [NSMutableArray arrayWithArray:groups];
            [otherGroups removeObjectIdenticalTo:group];
            NSMutableArray* otherItems = [NSMutableArray arrayWithArray:items];
            [otherItems removeObject:[optimal satisfyingItem]];
            optimalRemainder = [self optimalPickFromItems:otherItems usingItemGroups:otherGroups];
        }
        if(!optimalRemainder){
            // Choosing things in this specific order makes things unsatisfiable,
            // We can skip to the next configuration
            continue;
        }
        NSDecimalNumber* savings = [optimal savings];
        for(ItemGroup* otherOptimal in optimalRemainder){
            savings = [savings decimalNumberByAdding:[otherOptimal savings]];
        }
        if([savings compare:bestSavings] == NSOrderedDescending){
            bestSavings = savings;
            bestChoice = [optimalRemainder arrayByAddingObject:optimal];
        }
    }
    return bestChoice;
}

-(NSString *)description
{
    return @"Trivial pricing strategy";
}

@end
