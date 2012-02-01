//
//  Option.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Option.h"
#import "Choice.h"
#import "Item.h"

@implementation Option

NSString* OPTION_MODIFIED = @"CroutonLabs/OptionModified";

@synthesize lowerBound;
@synthesize upperBound;
@synthesize numberOfFreeChoices;
@synthesize choiceList;
@synthesize selectedChoices;
@synthesize propertiesChecksum;


-(Option *)initFromOption:(Option *)anOption
{
    self = [super initFromMenuComponent:anOption];

    lowerBound = anOption.lowerBound;
    upperBound = anOption.upperBound;
    numberOfFreeChoices = anOption.numberOfFreeChoices;
    choiceList = [[NSMutableArray alloc] initWithCapacity:0];
    selectedChoices = [[NSMutableArray alloc] initWithCapacity:0];
            
    for (Choice *aChoice in anOption.choiceList) {
        Choice *aNewChoice = [[Choice alloc] initFromChoice:aChoice option:self];
        [choiceList addObject:aNewChoice];
        if ([aChoice selected])
            [self selectChoice:aNewChoice];
    }
    
    //sort the choice list by real price
    [choiceList sortUsingSelector:@selector(comparePrice:)];
    
    propertiesChecksum = [anOption propertiesChecksum];
    
    return self;
    
}

-(Option *)initFromData:(NSDictionary *)inputData
{
    self = [super initFromData:inputData];
    upperBound = [[inputData objectForKey:@"max_choice"] intValue];
    lowerBound = [[inputData objectForKey:@"min_choice"] intValue];
    numberOfFreeChoices = [[inputData objectForKey:@"free_choice"] intValue];
    
    selectedChoices = [[NSMutableArray alloc] initWithCapacity:0];
    
    choiceList = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSDictionary *choice in [inputData objectForKey:@"choices"]) {
        Choice *newChoice = [[Choice alloc] initFromData:choice option:self];
        [choiceList addObject:newChoice];
    }
    
    //sort the choice list by real price
    [choiceList sortUsingSelector:@selector(comparePrice:)];
    
    for (Choice *choice in choiceList) {
        if(choice.selected)
        {
            [selectedChoices addObject:choice];
        }
    }
    
    if (lowerBound > 0)
    {
        for (int i = 0; i < lowerBound; i++)
        {
            [self selectChoice:[choiceList objectAtIndex:i]];
        }
    }
    
    propertiesChecksum = [inputData objectForKey:@"properties_checksum"];
    
    return self;
}

-(Option *)init{
    self = [super init];
    
    choiceList = [[NSMutableArray alloc] initWithCapacity:0];
    selectedChoices = [[NSMutableArray alloc] initWithCapacity:0];
    
    return self;
}



-(NSArray*)selectedFreeChoices{
    return [[selectedChoices sortedArrayUsingSelector:@selector(comparePrice:)] 
            subarrayWithRange:
            NSMakeRange(MAX((NSInteger)[selectedChoices count] - numberOfFreeChoices, 0), 
            MIN(numberOfFreeChoices, [selectedChoices count]))];
}

-(NSInteger)remainingFreeChoices{
    return MAX(0, numberOfFreeChoices - [selectedChoices count]);
}

-(NSDecimalNumber*)totalPrice{
    
    NSDecimalNumber* tabulation = [NSDecimalNumber zero];
    
    NSArray* sorted = [selectedChoices sortedArrayUsingSelector:@selector(comparePrice:)];
    NSArray* extra = [sorted subarrayWithRange:
                      NSMakeRange(0, MAX((NSInteger)([sorted count] - numberOfFreeChoices), 0))];
    
    for (Choice* choice in extra){
        tabulation = [tabulation decimalNumberByAdding:[choice price]];
    }
    
    return tabulation;
}

-(void) addPossibleChoice:(Choice *) aChoice{
    [choiceList addObject:aChoice];
    //sort the choice list by real price
    [choiceList sortUsingSelector:@selector(comparePrice:)];
    [[NSNotificationCenter defaultCenter] postNotificationName:OPTION_MODIFIED object:self];
}

-(BOOL) selectChoice:(Choice *) aChoice{
    
    if ([choiceList containsObject:aChoice]){
        if(upperBound <= 1)
        {
            [selectedChoices addObject:aChoice];
            if([selectedChoices count] > upperBound){
                [self deselectChoice:[selectedChoices objectAtIndex:0]];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:OPTION_MODIFIED object:self];
            return YES;
        }
        else
        {
            if(upperBound > [selectedChoices count]){
                [selectedChoices addObject:aChoice];
                [[NSNotificationCenter defaultCenter] postNotificationName:OPTION_MODIFIED object:self];
                return YES;
            }
            else{
                return NO;
            }
        }
    }
    else{
        NSLog(@"Warning: A selection of a choice that is invalid was attempted%@", nil);
        [[NSNotificationCenter defaultCenter] postNotificationName:OPTION_MODIFIED object:self];
        return YES;
    }
}

-(void) deselectChoice:(Choice *) aChoice{
    
    if ([choiceList containsObject:aChoice]){
        if ([selectedChoices count] > lowerBound){
            [selectedChoices removeObject:aChoice];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:OPTION_MODIFIED object:self];
    }
    else{
        NSLog(@"Warning: A deselection of a choice that is invalid was attempted%@", nil);
    }
    
}

-(BOOL) toggleChoice:(Choice *) aChoice{
    if(aChoice.selected){
        [self deselectChoice:aChoice];
        return YES;
    }
    else{
        return [self selectChoice:aChoice];
    }
}

//These three selectors just call the other selectors
-(BOOL)selectChoiceByIndex:(NSInteger)aChoice{
    
    return [self selectChoice:[choiceList objectAtIndex:aChoice]];
    
}

-(void)deselectChoiceByIndex:(NSInteger)aChoice{
    
    [self deselectChoice:[choiceList objectAtIndex:aChoice]];
    
}

-(BOOL)toggleChoiceByIndex:(NSInteger)aChoice
{
    
    return [self toggleChoice:[choiceList objectAtIndex:aChoice]];
    
}

-(NSDictionary*)orderRepresentation{
    NSMutableDictionary* repr = [NSMutableDictionary dictionaryWithCapacity:2];
    [repr setObject:[NSNumber numberWithInt:primaryKey] forKey:@"option"];
    NSMutableArray* orderchoices = [NSMutableArray arrayWithCapacity:[selectedChoices count]];
    for(Choice* orderchoice in selectedChoices){
        [orderchoices addObject:[orderchoice orderRepresentation]];
    }
    [repr setObject:orderchoices forKey:@"choices"];
    return repr;
}

- (MenuComponent *)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        lowerBound = [[decoder decodeObjectForKey:@"lower_bound"] intValue];
        upperBound = [[decoder decodeObjectForKey:@"upper_bound"] intValue];
        numberOfFreeChoices = [[decoder decodeObjectForKey:@"number_of_free_choices"] intValue];
        choiceList = [decoder decodeObjectForKey:@"choice_list"];
        selectedChoices = [decoder decodeObjectForKey:@"selected_choices"];
        propertiesChecksum = [decoder decodeObjectForKey:@"properties_checksum"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Rinse and repeat this:
    [super encodeWithCoder:encoder];
    [encoder encodeObject:[NSString stringWithFormat:@"%i", lowerBound] forKey:@"lower_bound"];
    [encoder encodeObject:[NSString stringWithFormat:@"%i", upperBound] forKey:@"upper_bound"];
    [encoder encodeObject:[NSString stringWithFormat:@"%i", numberOfFreeChoices] forKey:@"number_of_free_choices"];
    [encoder encodeObject:choiceList forKey:@"choice_list"];
    [encoder encodeObject:selectedChoices forKey:@"selected_choices"];
    [encoder encodeObject:propertiesChecksum forKey:@"properties_checksum"];
}

-(BOOL)isEffectivelySameAs:(Option *)anOption
{
    if (![[anOption name] isEqual: name])
        return NO;
    
    if([[anOption choiceList] count] != [choiceList count])
        return NO;
    
    for (int i = 0; i < [choiceList count]; i++) {
        if (![[[anOption choiceList] objectAtIndex:i] isEffectivelySameAs:[choiceList objectAtIndex:i]]) {
            return NO;
        }
    }
    return YES;
}

- (NSString *) descriptionWithIndent:(NSInteger) indentLevel
{    
    NSMutableString *output = [NSMutableString stringWithString:[@"" stringByPaddingToLength:(indentLevel*4) withString:@" " startingAtIndex:0]];
    
    [output appendFormat:@"option: %@ with choices:\n",name];
    
    for (Choice *aChoice in choiceList) {
        [output appendFormat:@"%@\n",[aChoice descriptionWithIndent:(indentLevel + 1)]];
    }
    
    return output;
}

-(NSString *)description{
    
    NSMutableString *output = [[NSMutableString alloc] initWithFormat:@"option: %@ with choices:\n",name];
    
    for (Choice *aChoice in choiceList) {
        [output appendFormat:@"%@\n",[aChoice descriptionWithIndent:1]];
    }
    
    return output;
    
}

@end
