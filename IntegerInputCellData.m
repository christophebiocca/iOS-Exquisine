//
//  IntegerInputCellData.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IntegerInputCellData.h"
#import "NSMutableNumber.h"

@implementation IntegerInputCellData

@synthesize number;
@synthesize lowerBound;
@synthesize upperBound;
@synthesize numberPrompt;

-(void)plus
{
    if ([number intValue] + 1 <= [upperBound intValue]) {
        [number addNumber:[NSNumber numberWithInt:1]];
    }
}

-(void)minus
{
    if ([number intValue] - 1 >= [lowerBound intValue]) {
        [number addNumber:[NSNumber numberWithInt:-1]];
    }
}

@end
