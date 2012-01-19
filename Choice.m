//
//  Choice.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Choice.h"

@implementation Choice

@synthesize normalPriceCents;
@synthesize effectivePriceCents;
@synthesize selected;

-(Choice *)initFromChoice:(Choice *)aChoice
{
    self = [super initFromMenuComponent:aChoice];
    
    normalPriceCents = aChoice.normalPriceCents;
    effectivePriceCents = aChoice.effectivePriceCents;
    selected = aChoice.selected;
    
    return self;
}

-(Choice *)initFromData:(NSData *)inputData
{
    self = [super initFromData:inputData];
    
    normalPriceCents = [[inputData valueForKey:@"price_cents"] intValue];
    effectivePriceCents = 0;
    selected = NO;
    
    return self;
}

-(NSString *)description{
    
    return [NSString stringWithFormat:@"%@ - C%i", name, normalPriceCents];
    
}

-(void)toggleSelected{
    selected = !selected;
}

@end
