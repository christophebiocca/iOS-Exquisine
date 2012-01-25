//
//  Option.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Option.h"
#import "Choice.h"

@implementation Option

@synthesize lowerBound;
@synthesize upperBound;
@synthesize numberOfFreeChoices;
@synthesize choiceList;
@synthesize selectedChoices;

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
    }
    
    //sort the choice list by real price
    [choiceList sortUsingSelector:@selector(comparePrice:)];
    
    for (Choice *choice in choiceList) {
        if(choice.selected)
        {
            [selectedChoices addObject:choice];
        }
    }
    
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
    
    return self;
}

-(Option *)init{
    
    choiceList = [[NSMutableArray alloc] initWithCapacity:0];
    selectedChoices = [[NSMutableArray alloc] initWithCapacity:0];
    
    return self;
}

-(NSString *)description{
    
    return [NSString stringWithFormat:@"%@: %@", name, [self selectedChoices]];
    
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
}

-(BOOL) selectChoice:(Choice *) aChoice{
    
    if ([choiceList containsObject:aChoice]){
        if(upperBound <= 1)
        {
            [selectedChoices addObject:aChoice];
            if([selectedChoices count] > upperBound){
                [self deselectChoice:[selectedChoices objectAtIndex:0]];
            }
            return YES;
        }
        else
        {
            if(upperBound > [selectedChoices count]){
                [selectedChoices addObject:aChoice];
                return YES;
            }
            else{
                return NO;
            }
        }
    }
    else{
        NSLog(@"Warning: A selection of a choice that is invalid was attempted%@", nil);
        return YES;
    }
}

-(void) deselectChoice:(Choice *) aChoice{
    
    if ([choiceList containsObject:aChoice]){
        if ([selectedChoices count] > lowerBound){
            [selectedChoices removeObject:aChoice];
        }
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

-(BOOL)toggleChoiceByIndex:(NSInteger)aChoice{
    
    return [self toggleChoice:[choiceList objectAtIndex:aChoice]];
    
}

@end
