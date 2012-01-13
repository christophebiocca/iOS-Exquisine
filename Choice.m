//
//  Choice.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Choice.h"

@implementation Choice

@synthesize name;
@synthesize normalPriceCents;
@synthesize effectivePriceCents;
@synthesize desc;
@synthesize selected;

-(NSString *)description{
    
    return [NSString stringWithFormat:@"%@ - C%i", name, normalPriceCents];
    
}

-(void)toggleSelected{
    selected = !selected;
}

@end
