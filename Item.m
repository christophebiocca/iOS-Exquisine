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

@synthesize name;
@synthesize basePriceCents;
@synthesize options; 
@synthesize desc;

-(NSString *)description{
    
    return [NSString stringWithFormat:@"%@, C%i, with options: %@", name, basePriceCents, options];
}

-(id)init{
    
    options = [[NSMutableArray 	alloc] init];
    
    return self;
}

-(void)addOption:(Option *)anOption{
    
    [options addObject:anOption];
    
}

-(NSInteger)totalPrice{
    NSInteger tabulation = basePriceCents;
    
    for (Option *currentOption in options) {
        tabulation += currentOption.totalPrice;
    }
    
    NSLog(@"The price found was: %i", tabulation);
    return tabulation;
}

@end
