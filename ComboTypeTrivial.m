//
//  ComboType1.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-07.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComboTypeTrivial.h"
#import "ItemGroup.h"

@implementation ComboTypeTrivial

-(NSDecimalNumber *)price
{
    NSDecimalNumber *tally = [NSDecimalNumber decimalNumberWithString:@"0"];
    for (ItemGroup *eachItemGroup in listOfItemGroups) {
        tally = [tally decimalNumberByAdding:[eachItemGroup price]];
    }
    return tally;
}

@end
