//
//  Utilities.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+(NSString *)FormatToPrice:(NSDecimalNumber*)price
{
    
    if([price isEqual:[NSDecimalNumber zero]])
    {
        return @"Free!";
    }
    return [NSNumberFormatter localizedStringFromNumber:price 
                                            numberStyle:NSNumberFormatterCurrencyStyle];
}

+(NSInteger)CompositeListCount:(NSMutableArray *) compositeList
{
    NSInteger tally = 0;
    
    for (NSMutableArray *compositeMember in compositeList) {
        tally += [compositeMember count];
    }
    
    return tally;
}

+(id)MemberOfCompositeListAtIndex:(NSMutableArray *)compositeList:(NSInteger)anInt
{
    if (compositeList == nil) {
        return nil;
    }
    int indicesLeft = anInt + 1;
    int membersTraversed = 0;
    
    while (indicesLeft > 0)
    {
        if([[compositeList objectAtIndex:membersTraversed]count] >= indicesLeft)
            return [[compositeList objectAtIndex:membersTraversed] objectAtIndex:(indicesLeft-1)];
        indicesLeft -= [[compositeList objectAtIndex:membersTraversed]count];
        membersTraversed ++;
    }
    return nil;
}

@end
