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
@synthesize basePrice;
@synthesize propertiesChecksum;

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@, %@, with options: %@", name, basePrice, options];
}

-(Item *)initFromItem:(Item *)anItem
{
    self = [super initFromMenuComponent:anItem];
    
    basePrice = anItem.basePrice;
    options = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (Option *currentOption in anItem.options) {
        Option *anOption = [[Option alloc] initFromOption:currentOption];
        [options addObject:anOption];
    }
    
    propertiesChecksum = [anItem propertiesChecksum];
    
    return self;
}

-(Item *)initFromData:(NSDictionary *)inputData
{
    self = [super initFromData:inputData];
    NSInteger cents = [[inputData objectForKey:@"price_cents"] intValue];
    basePrice = [[[NSDecimalNumber alloc] initWithInteger:cents] decimalNumberByMultiplyingByPowerOf10:-2];
    
    propertiesChecksum = [inputData valueForKey:@"properties_checksum"];
    
    options = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSDictionary *option in [inputData objectForKey:@"all_options"]) {
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

-(NSDecimalNumber*)totalPrice
{
    NSDecimalNumber* tabulation = basePrice;
    
    for (Option *currentOption in options) 
    {
        tabulation = [tabulation decimalNumberByAdding:[currentOption totalPrice]];
    }
    
    return tabulation;
}

@end
