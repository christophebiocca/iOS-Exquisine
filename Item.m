//
//  Item.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Item.h"
#import "Option.h"
#import "Utilities.h"

@implementation Item

NSString* ITEM_MODIFIED = @"CroutonLabs/ItemModified";

@synthesize options;
@synthesize basePrice;
@synthesize propertiesChecksum;

-(Item *)initFromItem:(Item *)anItem
{
    self = [super initFromMenuComponent:anItem];
    
    basePrice = anItem.basePrice;
    options = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (Option *currentOption in anItem.options) {
        Option *anOption = [[Option alloc] initFromOption:currentOption];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(optionAltered) name:OPTION_MODIFIED object:anOption];
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
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(optionAltered) name:OPTION_MODIFIED object:newOption];
        
        [options addObject:newOption];
    }
    
    return self;
}

-(Item *)init
{
    self = [super init];
    options = [[NSMutableArray alloc] initWithCapacity:0];
    return self;
}

-(void)addOption:(Option *)anOption
{
    [options addObject:anOption];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(optionAltered) name:OPTION_MODIFIED object:anOption];
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

-(BOOL)isEffectivelySameAs:(Item *)anItem
{
    if (![name isEqual:[anItem name]])
        return NO;
    if ([options count] != [[anItem options] count])
        return NO;
    for (int i = 0; i < [options count] ; i++) {
        if (![[options objectAtIndex:i] isEffectivelySameAs:[[anItem options] objectAtIndex:i]])
            return NO;
    }
    return YES;
}

-(NSComparisonResult)nameSort:(Item *)anItem
{
    return [name compare:anItem.name];
}

-(NSComparisonResult)priceSort:(Item *)anItem
{
    return [[anItem totalPrice] compare:[self totalPrice]];
}

- (NSString *) descriptionWithIndent:(NSInteger) indentLevel
{    
    NSMutableString *output = [NSMutableString stringWithString:[@"" stringByPaddingToLength:(indentLevel*4) withString:@" " startingAtIndex:0]];
    
    [output appendFormat:@"Item: %@ with price %@ and options:\n",name,[Utilities FormatToPrice:basePrice]];
    
    for (Option *anOption in options) {
        [output appendFormat:@"%@\n",[anOption descriptionWithIndent:(indentLevel + 1)]];
    }
    
    return output;
}

-(NSString *)description{
    
    NSMutableString *output = [[NSMutableString alloc] initWithFormat:@"Item: %@ with price %@ and options:\n",name,[Utilities FormatToPrice:basePrice]];
    
    for (Option *anOption in options) {
        [output appendFormat:@"%@\n",[anOption descriptionWithIndent:1]];
    }
    
    return output;
    
}

-(void) optionAltered
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ITEM_MODIFIED object:self];
}

-(NSString *)reducedName
{
    
    NSRegularExpression* firstPart = [NSRegularExpression 
                                      regularExpressionWithPattern:@"\\A\\S+" 
                                      options:0 
                                      error:nil];
    
    NSTextCheckingResult* match = [firstPart firstMatchInString:name options:0 range:NSMakeRange(0, [name length])];
    
    return [name substringWithRange:[match range]];
}

@end
