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
#import "NSMutableNumber.h"

@implementation Item

NSString* ITEM_MODIFIED = @"CroutonLabs/ItemModified";

@synthesize options;
@synthesize basePrice;
@synthesize numberOfItems;

-(Item *)init
{
    self = [super init];
    
    options = [[NSMutableArray alloc] initWithCapacity:0];
    basePrice = [[NSDecimalNumber alloc] initWithInt:0];
    numberOfItems = [[NSMutableNumber alloc] initWithNumber:[NSNumber numberWithInt:1]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(numberAltered) name:NUMBER_MODIFIED object:numberOfItems];
    
    return self;
}

-(Item *)initFromData:(NSDictionary *)inputData
{
    
    self = [super initFromData:inputData];
    NSInteger cents = [[inputData objectForKey:@"price_cents"] intValue];
    basePrice = [[[NSDecimalNumber alloc] initWithInteger:cents] decimalNumberByMultiplyingByPowerOf10:-2];
    
    options = [[NSMutableArray alloc] initWithCapacity:0];
    
    numberOfItems = [[NSMutableNumber alloc] initWithNumber:[NSNumber numberWithInt:1]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(numberAltered) name:NUMBER_MODIFIED object:numberOfItems];
    
    for (NSDictionary *option in [inputData objectForKey:@"all_options"]) {
        
        Option *newOption = [[Option alloc] initFromData:option];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(optionAltered) name:OPTION_MODIFIED object:newOption];
        [options addObject:newOption];
    }
    
    return self;
}

-(void) basePriceRecovery:(NSCoder *)decoder
{
    switch (harddiskDataVersion) {
        case VERSION_0_0_0:
            //fall through to next
        case VERSION_1_0_0:
            //fall through to next
        case VERSION_1_0_1:
            basePrice = [decoder decodeObjectForKey:@"base_price"];
        case VERSION_1_1_0:
            break;
        default:
            break;
    }
}

-(void) numberOfItemsRecovery:(NSCoder *)decoder
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(numberAltered) name:NUMBER_MODIFIED object:numberOfItems];
}

-(Item *)copy;
{
    Item * anItem = [[Item alloc] init];
    
    anItem->name = name;
    anItem->desc = desc;
    anItem->primaryKey = primaryKey; 
    anItem->basePrice = basePrice;
    anItem->numberOfItems = [[NSMutableNumber alloc] initWithNumber:[NSNumber numberWithInt:[numberOfItems intValue]]];
    [[NSNotificationCenter defaultCenter] addObserver:anItem selector:@selector(numberAltered) name:NUMBER_MODIFIED object:anItem->numberOfItems];
    
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

-(void)numberAltered
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
    
    return [tabulation decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%i" ,[numberOfItems intValue]]]];
}

-(BOOL)isEffectivelyEqual:(id)anItem
{
    if (![anItem isKindOfClass:[Item class]]) 
        return NO;
    if (! (primaryKey == [anItem primaryKey]))
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
