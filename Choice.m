//
//  Choice.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Choice.h"
#import "Option.h"

@implementation Choice

@synthesize price;

-(Choice *)initFromChoice:(Choice *)aChoice option:(Option *)opt
{
    self = [super initFromMenuComponent:aChoice];
    
    price = aChoice.price;
    selected = aChoice.selected;
    option = opt;
    
    return self;
}

-(Choice *)initFromData:(NSData *)inputData option:(Option *)opt
{
    self = [super initFromData:inputData];
    NSDecimalNumber* priceCents = [[NSDecimalNumber alloc] 
                                   initWithInteger:[[inputData 
                                                     valueForKey:@"price_cents"] intValue]];
    price = [priceCents decimalNumberByMultiplyingByPowerOf10:-2];
    selected = NO;
    option = opt;
    return self;
}

-(NSString *)description{
    
    return [NSString stringWithFormat:@"%@ - %@", name, price];
    
}

-(NSComparisonResult)comparePrice:(Choice*)other{
    return [[self price] compare:[other price]];
}

-(BOOL)selected{
    return [[option selectedChoices] containsObject:self];
}

-(BOOL)isFree{
    if([self selected]){
        return [[option selectedFreeChoices] containsObject:self];
    } else {
        return [option remainingFreeChoices] > 0;
    }
}

@end
