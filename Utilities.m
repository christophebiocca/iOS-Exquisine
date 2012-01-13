//
//  Utilities.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+(NSString *)FormatToPrice:(NSInteger)anInt{
    
    if(anInt == 0){
        return @"Free!";
    }
    
    NSNumber *helper = [NSNumber numberWithFloat:(float)anInt/100];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    return [formatter stringFromNumber:helper];
}

@end
