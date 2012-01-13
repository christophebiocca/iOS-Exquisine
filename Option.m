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

@synthesize name;
@synthesize lowerBound;
@synthesize upperBound;
@synthesize numberOfFreeChoices;
@synthesize choiceList;
@synthesize selectedChoices;

-(id)init{
    
    choiceList = [[NSMutableArray alloc] initWithCapacity:0];
    selectedChoices = [[NSMutableArray alloc] initWithCapacity:0];
    
    return self;
}

-(NSString *)description{
    
    return [NSString stringWithFormat:@"%@: %@", name, [self selectedChoices]];
    
}



-(void) addPossibleChoice:(Choice *) aChoice{
    [choiceList addObject:aChoice];
    [self updatePrices];
}



-(BOOL) selectChoice:(Choice *) aChoice{
    
    if ([choiceList containsObject:aChoice]){
        if(upperBound <= 1)
        {
            [aChoice setSelected:YES];
            [selectedChoices addObject:aChoice];
            if([selectedChoices count] > upperBound){
                [self deselectChoice:[selectedChoices objectAtIndex:0]];
            }
            [self updatePrices];
            return YES;
        }
        else
        {
            if(upperBound > [selectedChoices count]){
                [aChoice setSelected:YES];
                [selectedChoices addObject:aChoice];
                [self updatePrices];
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
            [[choiceList objectAtIndex:[choiceList indexOfObject:aChoice]] setSelected:NO];
            [selectedChoices removeObject:aChoice];
            [self updatePrices];
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

-(NSInteger)totalPrice{
    
    NSInteger tabulation = 0;
    
    for (int n = 0; n < [[self selectedChoices] count] ; n++){
        tabulation += [[[self selectedChoices] objectAtIndex:n] effectivePriceCents];
    }
    
    return tabulation;
}

//This subroutine is the meat of the logic behind price management. Any time someone adds a choice,
//or selects something, this subroutine will be called to make sure the effective prices accurately reflect
//the situation.
-(void)updatePrices{
    
    //sort the choice list by real price
    [choiceList sortUsingComparator:^(id firstChoice, id secondChoice){
        return [firstChoice normalPriceCents] < [secondChoice normalPriceCents];
    }];
    
    NSInteger numberOfSelections = [[self selectedChoices] count];
    NSInteger numberOfSelectonsMarkedFree = 0;
     
    for (Choice *currentChoice in choiceList) {
        if(currentChoice.selected){
            if(numberOfFreeChoices > numberOfSelectonsMarkedFree){
                numberOfSelectonsMarkedFree ++;
                currentChoice.effectivePriceCents = 0;
            }
            else{
                currentChoice.effectivePriceCents = currentChoice.normalPriceCents;
            }
        }
        else{
            if(numberOfFreeChoices > numberOfSelections){
                currentChoice.effectivePriceCents = 0;
            }
            else{
                currentChoice.effectivePriceCents = currentChoice.normalPriceCents;
            }
        }
    }
}


@end
