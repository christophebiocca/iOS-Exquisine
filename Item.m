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

-(Item *)init
{
    self = [super init];
    
    options = [[NSMutableArray alloc] initWithCapacity:0];
    basePrice = [[NSDecimalNumber alloc] initWithInt:0];
    
    return self;
}

-(Item *)initFromData:(NSDictionary *)inputData
{
    
    self = [super initFromData:inputData];
    NSInteger cents = [[inputData objectForKey:@"price_cents"] intValue];
    basePrice = [[[NSDecimalNumber alloc] initWithInteger:cents] decimalNumberByMultiplyingByPowerOf10:-2];
    
    options = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSDictionary *option in [inputData objectForKey:@"all_options"]) {
        
        Option *newOption = [[Option alloc] initFromData:option];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(optionAltered) name:OPTION_MODIFIED object:newOption];
        [options addObject:newOption];
    }
    
    return self;
}

- (MenuComponent *)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        basePrice = [decoder decodeObjectForKey:@"base_price"];
        options = [decoder decodeObjectForKey:@"options"];
        
        for (Option *option in options) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(optionAltered) name:OPTION_MODIFIED object:option];
        }
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Rinse and repeat this:
    [super encodeWithCoder:encoder];
    [encoder encodeObject:basePrice forKey:@"base_price"];
    [encoder encodeObject:options forKey:@"options"];
}

-(Item *)copy;
{
    Item * anItem = [[Item alloc] init];
    
    anItem->name = name;
    anItem->desc = desc;
    anItem->primaryKey = primaryKey; 
    anItem->basePrice = basePrice;
    
    anItem->options = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (Option *currentOption in options) {
        Option *anOption = [currentOption copy];
        [[NSNotificationCenter defaultCenter] addObserver:anItem selector:@selector(optionAltered) name:OPTION_MODIFIED object:anOption];
        [anItem.options addObject:anOption];
    }
    
    return anItem;
}


-(void)addOption:(Option *)anOption
{
    [options addObject:anOption];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(optionAltered) name:OPTION_MODIFIED object:anOption];
    [[NSNotificationCenter defaultCenter] postNotificationName:ITEM_MODIFIED object:self];
}

-(void) optionAltered
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ITEM_MODIFIED object:self];
}

-(NSDecimalNumber*)price
{
    NSDecimalNumber* tabulation = basePrice;
    
    for (Option *currentOption in options) 
    {
        tabulation = [tabulation decimalNumberByAdding:[currentOption price]];
    }
    
    return tabulation;
}

-(BOOL)isEffectivelyEqual:(id)anItem
{
    if (![anItem isKindOfClass:[Item class]]) 
        return NO;
    if (![name isEqual:[anItem name]])
        return NO;
    if ([options count] != [[(Item *)anItem options] count])
        return NO;
    for (int i = 0; i < [options count] ; i++) {
        if (![[options objectAtIndex:i] isEffectivelyEqual:[[(Item *)anItem options] objectAtIndex:i]])
            return NO;
    }
    return YES;
}

-(NSComparisonResult) nameSort:(Item *)anItem
{
    return [name compare:anItem.name];
}

-(NSComparisonResult)priceSort:(Item *)anItem
{
    return [[anItem price] compare:[self price]];
}


-(NSDictionary*)orderRepresentation{
    NSMutableDictionary* representation = [NSMutableDictionary dictionaryWithCapacity:2];
    [representation setObject:[NSNumber numberWithInt:primaryKey] forKey:@"item"];
    NSMutableArray* orderoptions = [NSMutableArray array];
    for(Option* option in options){
        [orderoptions addObject:[option orderRepresentation]];
    }
    [representation setObject:orderoptions forKey:@"options"];
    return representation;
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

- (NSString *) descriptionWithIndent:(NSInteger) indentLevel
{    
    NSString *padString = [@"" stringByPaddingToLength:(indentLevel*4) withString:@" " startingAtIndex:0];
    
    NSMutableString *output = [[NSMutableString alloc] initWithCapacity:0];
    
    [output appendFormat:@"%@Item:%\n",padString];
    [output appendString:[super descriptionWithIndent:indentLevel]];
    [output appendFormat:@"%@Base price: %@\n",padString,basePrice];
    [output appendFormat:@"%@Price: %@\n",padString,[self price]];
    [output appendFormat:@"%@Options:\n",padString];
    
    for (Option *anOption in options) {
        [output appendFormat:@"%@\n",[anOption descriptionWithIndent:(indentLevel + 1)]];
    }
    
    return output;
}

-(void)dealloc
{
    for (Option *eachOption in options) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

@end
