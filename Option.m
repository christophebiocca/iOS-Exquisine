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
NSString* OPTION_CHOICE_ADDED = @"CroutonLabs/OptionChoiceAdded";
NSString* OPTION_CHOICE_REMOVED = @"CroutonLabs/OptionChoiceRemoved";
NSString* OPTION_INVALID_SELECTION = @"CroutonLabs/OptionInvalidSelection";
NSString* OPTION_INVALID_DESELECTION = @"CroutonLabs/OptionInvalidDeselection";

@synthesize lowerBound;
@synthesize upperBound;
@synthesize numberOfFreeChoices;
@synthesize choiceList;

-(Option *)init
{
    self = [super init];
    
    choiceList = [[NSMutableArray alloc] initWithCapacity:0];
    
    return self;
}

-(Option *)initFromData:(NSDictionary *)inputData
{
    self = [super initFromData:inputData];
    
    lowerBound = [[inputData objectForKey:@"min_choice"] intValue];
    upperBound = [[inputData objectForKey:@"max_choice"] intValue];
    numberOfFreeChoices = [[inputData objectForKey:@"free_choice"] intValue];
    
    choiceList = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSDictionary *choice in [inputData objectForKey:@"choices"]) {
        Choice *newChoice = [[Choice alloc] initFromData:choice option:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recalculate:) name:CHOICE_SELECTED_CHANGED object:newChoice];        
        [choiceList addObject:newChoice];
    }
    
    [self recalculate:nil];
    
    return self;
}

-(void) choiceListRecovery:(NSCoder *)decoder
{
    switch (harddiskDataVersion) {
        case VERSION_0_0_0:
            //fall through to next
        case VERSION_1_0_0:
            //fall through to next
        case VERSION_1_0_1:
            choiceList = [decoder decodeObjectForKey:@"choice_list"];
        case VERSION_1_1_0:
            for (Choice *newChoice in choiceList) {
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recalculate:) name:CHOICE_SELECTED_CHANGED object:newChoice];
            }
            break;
        default:
            break;
    }
}

- (MenuComponent *)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        lowerBound = [[decoder decodeObjectForKey:@"lower_bound"] intValue];
        upperBound = [[decoder decodeObjectForKey:@"upper_bound"] intValue];
        numberOfFreeChoices = [[decoder decodeObjectForKey:@"number_of_free_choices"] intValue];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [super encodeWithCoder:encoder];
    [encoder encodeObject:[NSString stringWithFormat:@"%i", lowerBound] forKey:@"lower_bound"];
    [encoder encodeObject:[NSString stringWithFormat:@"%i", upperBound] forKey:@"upper_bound"];
    [encoder encodeObject:[NSString stringWithFormat:@"%i", numberOfFreeChoices] forKey:@"number_of_free_choices"];
}

-(Option *)copy
{
    
    Option *anOption = [[Option alloc] init];
    
    anOption->name = name;
    anOption->desc = desc;
    anOption->primaryKey = primaryKey;
    
    anOption->lowerBound = lowerBound;
    anOption->upperBound = upperBound;
    anOption->numberOfFreeChoices = numberOfFreeChoices;
    
    for (Choice *aChoice in choiceList) {
        [anOption addChoice:[aChoice copy]];
    }
    
    return anOption;
    
}

-(NSDecimalNumber*)price
{
    NSDecimalNumber* tabulation = [NSDecimalNumber zero];

    for (Choice* choice in [self selectedChoices]){
        tabulation = [tabulation decimalNumberByAdding:[choice price]];
    }
    
    return tabulation;
}

-(NSArray *)selectedChoices
{
    NSMutableArray *output = [[NSMutableArray alloc] initWithCapacity:0];
    for (Choice *aChoice in choiceList) {
        if([aChoice selected])
            [output addObject:aChoice];
    }
    return output;
}

-(NSInteger) numberOfSelectedChoices;
{
    return [[self selectedChoices] count];
}

-(void) addChoice:(Choice *) aChoice{
    [choiceList addObject:aChoice];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recalculate:) name:CHOICE_SELECTED_CHANGED object:aChoice]; 
    [self recalculate:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:OPTION_CHOICE_ADDED object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:OPTION_MODIFIED object:self];
}

- (void) removeChoice:(Choice *) aChoice
{
    [choiceList removeObject:aChoice];
    [self recalculate:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:OPTION_CHOICE_REMOVED object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:OPTION_MODIFIED object:self];
}

//These three selectors just call the other selectors
-(void)selectChoiceByIndex:(NSInteger)aChoice
{
    
    [[choiceList objectAtIndex:aChoice] setSelected:YES];
    
}

-(void)selectChoiceByIndexUnsafe:(NSInteger)aChoice
{
    
    [[choiceList objectAtIndex:aChoice] setSelectedUnsafe:YES];
    
}

-(void)deselectChoiceByIndex:(NSInteger)aChoice
{
    
    [[choiceList objectAtIndex:aChoice] setSelected:NO];
    
}

-(void)deselectChoiceByIndexUnsafe:(NSInteger)aChoice
{
    
    [[choiceList objectAtIndex:aChoice] setSelectedUnsafe:NO];

}

-(void)toggleChoiceByIndex:(NSInteger)aChoice
{
    
    [[choiceList objectAtIndex:aChoice] toggleSelected];
    
}

//Whenever a choice gets modified, this guy makes sure it's handled correctly.
-(void)recalculate:(NSNotification *)aNotification
{
    [choiceList sortUsingSelector:@selector(comparePrice:)];
    
    Choice *theChoice = nil;
    
    if(aNotification)
    {
        theChoice = [aNotification object];
    }
    
    if (theChoice) 
    {
        if ([choiceList containsObject:theChoice])
        {
            if ([theChoice selected])
            {
                if(upperBound == 1)
                {
                    if([self numberOfSelectedChoices] > upperBound)
                    {
                        NSMutableArray *helper = [[NSMutableArray alloc] initWithArray:choiceList];
                        [helper removeObjectIdenticalTo:theChoice];
                        for (Choice *aChoice in helper) {
                            [aChoice setSelectedUnsafe:NO];
                        }
                    }
                    [[NSNotificationCenter defaultCenter] postNotificationName:OPTION_MODIFIED object:self];
                }
                else
                {
                    if([self numberOfSelectedChoices] <= upperBound)
                    {
                        [[NSNotificationCenter defaultCenter] postNotificationName:OPTION_MODIFIED object:self];
                    }
                    else
                    {
                        [theChoice setSelectedUnsafe:NO];
                        [[NSNotificationCenter defaultCenter] postNotificationName:OPTION_INVALID_SELECTION object:self];
                    }
                }
            }
            else
            {
                if ([self numberOfSelectedChoices] < lowerBound)
                {
                    [theChoice setSelectedUnsafe:YES];
                    [[NSNotificationCenter defaultCenter] postNotificationName:OPTION_INVALID_DESELECTION object:self];
                }
                else
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:OPTION_MODIFIED object:self];
                }
            }
        }
        else
        {
            CLLog(LOG_LEVEL_ERROR , [NSString stringWithFormat:@"A notification from a choice to which there is no pointer was recieved.\nMe:\n%@\nThe choice:\n%@", self, theChoice]);
            [[NSNotificationCenter defaultCenter] postNotificationName:OPTION_MODIFIED object:self];
        }
    }
    
    [self validateState];
}

-(void)validateState
{
    if (([self numberOfSelectedChoices] < lowerBound)||([self numberOfSelectedChoices] > upperBound))
    {
        //If this is the case, we need to know, but also we don't want the app to cack.
        //I'll log an error and try to recover.
        CLLog(LOG_LEVEL_WARNING, [NSString stringWithFormat: @"Option is in a bad state. \
              \n Here's a readout of the Option in a bad state before attempting to recover:\n%@",self]);
        
        //Recovery routine:
        int i = 0;
        while (([self numberOfSelectedChoices] > upperBound)) {
            [self deselectChoiceByIndexUnsafe:i];
            i++;
        }
        while (([self numberOfSelectedChoices] < lowerBound)) {
            [self selectChoiceByIndexUnsafe:i];
            i++;
        }
    }
    
    if ([[self selectedChoices] count] >= numberOfFreeChoices) {
        for (Choice *aChoice in choiceList) {
            [aChoice setIsFree:NO];
        }
    }
    else
    {
        for (Choice *aChoice in choiceList) {
            [aChoice setIsFree:YES];
        }
    }
    
    int j = 0;
    for (Choice *aChoice in [self selectedChoices]) {
        if (j >= numberOfFreeChoices) 
            [aChoice setIsFree:NO];
        else
            [aChoice setIsFree:YES];
        j++;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:OPTION_MODIFIED object:self];
}

-(BOOL)isEffectivelyEqual:(Option *)anOption
{
    if (![anOption primaryKey] == primaryKey)
        return NO;
    
    if([[anOption choiceList] count] != [choiceList count])
        return NO;
    
    for (int i = 0; i < [choiceList count]; i++) {
        if (![[[anOption choiceList] objectAtIndex:i] isEffectivelyEqual:[choiceList objectAtIndex:i]]) {
            return NO;
        }
    }
    return YES;
}

-(NSDictionary*)orderRepresentation{
    NSMutableDictionary* repr = [NSMutableDictionary dictionaryWithCapacity:2];
    [repr setObject:[NSNumber numberWithInt:primaryKey] forKey:@"option"];
    NSMutableArray* orderchoices = [NSMutableArray arrayWithCapacity:[self numberOfSelectedChoices]];
    for(Choice* orderchoice in [self selectedChoices]){
        [orderchoices addObject:[orderchoice orderRepresentation]];
    }
    [repr setObject:orderchoices forKey:@"choices"];
    return repr;
}

- (NSString *) descriptionWithIndent:(NSInteger) indentLevel
{
    NSString *padString = [@"" stringByPaddingToLength:(indentLevel*4) withString:@" " startingAtIndex:0];

    NSMutableString *output = [[NSMutableString alloc] initWithCapacity:0];

    [output appendFormat:@"%@Option:%\n",padString];
    [output appendString:[super descriptionWithIndent:indentLevel]];
    [output appendFormat:@"%@lower bound for choices:%i \n",padString,lowerBound];
    [output appendFormat:@"%@upper bound for choices:%i \n",padString,upperBound];
    [output appendFormat:@"%@number of free choices:%i \n",padString,numberOfFreeChoices];
    [output appendFormat:@"%@choices:\n",padString];
    
    for (Choice *aChoice in choiceList) {
        [output appendFormat:@"%@\n",[aChoice descriptionWithIndent:(indentLevel + 1)]];
    }
    
    return output;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
