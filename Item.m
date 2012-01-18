//
//  Item.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Item.h"
#import "Option.h"

@implementation Item

@synthesize options;
@synthesize basePriceCents;

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@, C%i, with options: %@", name, basePriceCents, options];
}

-(Item *)initFromData:(NSData *)inputData
{
    self = [super initFromData:inputData];
    basePriceCents = [[inputData valueForKey:@"price_cents"] intValue];
    
    options = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSData *option in [inputData valueForKey:@"options"]) {
        Option *newOption = [[Option alloc] initFromData:option];
        [options addObject:newOption];
    }
    
    return self;
}

-(Item *)init
{
    options = [[NSMutableArray alloc] initWithCapacity:0];
    return self;
}

-(void)addOption:(Option *)anOption
{
    [options addObject:anOption];
}

-(NSInteger)totalPrice
{
    NSInteger tabulation = basePriceCents;
    
    for (Option *currentOption in options) 
    {
        tabulation += currentOption.totalPrice;
    }
    
    return tabulation;
}

@end
