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
@synthesize propertiesChecksum;

-(Choice *)initFromChoice:(Choice *)aChoice option:(Option *)opt
{
    self = [super initFromMenuComponent:aChoice];
    
    price = aChoice.price;
    option = opt;
    propertiesChecksum = [aChoice propertiesChecksum];
    
    return self;
}

-(Choice *)initFromData:(NSDictionary *)inputData option:(Option *)opt
{
    self = [super initFromData:inputData];
    NSDecimalNumber* priceCents = [[NSDecimalNumber alloc] 
                                   initWithInteger:[[inputData 
                                                     objectForKey:@"price_cents"] intValue]];
    price = [priceCents decimalNumberByMultiplyingByPowerOf10:-2];
    option = opt;
    propertiesChecksum = [inputData objectForKey:@"properties_checksum"];
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

-(NSDictionary*)orderRepresentation{
    return [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:primaryKey] forKey:@"choice"];
}

- (MenuComponent *)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        option = [decoder decodeObjectForKey:@"option"];
        price = [decoder decodeObjectForKey:@"price"];
        propertiesChecksum = [decoder decodeObjectForKey:@"properties_checksum"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Rinse and repeat this:
    [super encodeWithCoder:encoder];
    [encoder encodeObject:option forKey:@"option"];
    [encoder encodeObject:price forKey:@"price"];
    [encoder encodeObject:propertiesChecksum forKey:@"properties_checksum"];
}

@end
