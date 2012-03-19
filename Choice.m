//
//  Choice.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Choice.h"
#import "Option.h"
#import "Utilities.h"
#import "MenuComponent.h"

NSString* CHOICE_PRICE_CHANGED = @"CroutonLabs/ChoicePriceChanged";
NSString* CHOICE_SELECTED_CHANGED = @"CroutonLabs/ChoiceSelectedChanged";
NSString* CHOICE_FREE_CHANGED = @"CroutonLabs/ChoiceFreeChanged";
NSString* CHOICE_CHANGED = @"CroutonLabs/ChoiceChanged";

@implementation Choice

@synthesize selected;
@synthesize isFree;

-(Choice *)initFromData:(NSDictionary *)inputData option:(Option *)anOption
{
    self = [super initFromData:inputData];
    
    NSDecimalNumber* priceCents = [[NSDecimalNumber alloc] initWithInteger:[[inputData objectForKey:@"price_cents"] intValue]];
    basePrice = [priceCents decimalNumberByMultiplyingByPowerOf10:-2];
    
    selected = [[inputData objectForKey:@"selected"] intValue];
    
    isFree = NO;

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
            basePrice = [decoder decodeObjectForKey:@"price"];
        case VERSION_1_1_0:
            break;
        default:
            break;
    }
}

- (MenuComponent *)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        selected = [[decoder decodeObjectForKey:@"selected"] intValue];
        isFree = [[decoder decodeObjectForKey:@"free"] boolValue];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [super encodeWithCoder:encoder];
    [encoder encodeObject:[NSString stringWithFormat:@"%i", selected] forKey:@"selected"];
    [encoder encodeObject:[NSString stringWithFormat:@"%i", isFree] forKey:@"free"];
}

- (Choice *)copy
{
    Choice *aChoice = [[Choice alloc] init];
    
    aChoice->name = name;
    aChoice->desc = desc;
    aChoice->primaryKey = primaryKey;
    
    aChoice->basePrice = basePrice;
    aChoice->selected = selected;
    aChoice->isFree = isFree;
        
    return aChoice;
}

- (void)setBasePrice:(NSDecimalNumber *)aPrice
{
    basePrice = aPrice;
    [[NSNotificationCenter defaultCenter] postNotificationName:CHOICE_PRICE_CHANGED object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:CHOICE_CHANGED object:self];
}

-(void)setSelected:(BOOL)isSelected
{
    selected = isSelected;
    [[NSNotificationCenter defaultCenter] postNotificationName:CHOICE_SELECTED_CHANGED object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:CHOICE_CHANGED object:self];
}

-(void)setSelectedUnsafe:(BOOL)isSelected
{
    selected = isSelected;
}

-(void)toggleSelected
{
    if(selected)
        [self setSelected:NO];
    else
        [self setSelected:YES];
}

-(void)setIsFree:(BOOL)free
{
    isFree = free;
    [[NSNotificationCenter defaultCenter] postNotificationName:CHOICE_FREE_CHANGED object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:CHOICE_CHANGED object:self];
    
}

-(BOOL)isFree
{
    return isFree||[basePrice isEqualToNumber:[NSNumber numberWithInt:0]];
}

-(void)setIsFreeUnsafe:(BOOL)free
{
    isFree = free;
    
}

-(NSDecimalNumber *)price
{
    if(isFree)
        return [NSDecimalNumber decimalNumberWithString:@"0"];
    return basePrice;
}

-(NSComparisonResult)comparePrice:(Choice*)other
{
    return [basePrice compare:other->basePrice];
}

-(BOOL)isEffectivelyEqual:(id)aChoice
{
    if (![aChoice isKindOfClass:[Choice class]])
        return NO;
    
    if(! (primaryKey == [aChoice primaryKey]))
        return NO;
    
    if(selected != [aChoice selected])
        return NO;
    
    return YES;
}

-(NSDictionary*)orderRepresentation
{
    return [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:primaryKey] forKey:@"choice"];
}

- (NSString *) descriptionWithIndent:(NSInteger) indentLevel
{    
    NSString *padString = [@"" stringByPaddingToLength:(indentLevel*4) withString:@" " startingAtIndex:0];
    
    NSMutableString *output = [[NSMutableString alloc] initWithCapacity:0];
    
    [output appendFormat:@"%@choice:\n",padString];
    [output appendString:[super descriptionWithIndent:indentLevel]];
    [output appendFormat:@"%@base price:%@ \n",padString,basePrice];
    [output appendFormat:@"%@selected:%i \n",padString,selected];
    [output appendFormat:@"%@is free:%i \n",padString,isFree];

    return output;
}

@end
