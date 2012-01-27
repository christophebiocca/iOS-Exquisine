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

-(NSDictionary*)orderRepresentation{
    NSMutableDictionary* repr = [NSMutableDictionary dictionaryWithCapacity:2];
    [repr setObject:[NSNumber numberWithInt:primaryKey] forKey:@"item"];
    NSMutableArray* orderoptions = [NSMutableArray array];
    for(Option* option in options){
        [orderoptions addObject:[option orderRepresentation]];
    }
    [repr setObject:orderoptions forKey:@"options"];
    return repr;
}

- (MenuComponent *)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        basePrice = [decoder decodeObjectForKey:@"base_price"];
        options = [decoder decodeObjectForKey:@"options"];
        propertiesChecksum = [decoder decodeObjectForKey:@"preoperties_checksum"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Rinse and repeat this:
    [super encodeWithCoder:encoder];
    [encoder encodeObject:basePrice forKey:@"base_price"];
    [encoder encodeObject:options forKey:@"options"];
    [encoder encodeObject:propertiesChecksum forKey:@"preoperties_checksum"];
}

@end
