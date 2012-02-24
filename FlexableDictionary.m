//
//  FlexableDictionary.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FlexableDictionary.h"

@implementation FlexableDictionary

-(id)init
{
    self = [super init];
    
    if (self) {
        info = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return self;
}

-(void)setAssociativeTuple:(id)objectOne :(id)objectTwo
{
    [info addObject:[NSArray arrayWithObjects:objectOne,objectTwo, nil]];
}

-(id)objectForKey:(id)key
{
    for (NSArray *eachArray in info) {
        if ([eachArray containsObject:key]) {
            return [eachArray objectAtIndex:(([eachArray indexOfObject:key] + 1)%2)];
        }
    }
    return nil;
}

@end
