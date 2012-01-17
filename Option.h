//
//  Option.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Choice.h"
#import "MenuComponent.h"

@interface Option : MenuComponent{
    
    NSString *name;
    NSInteger lowerBound;
    NSInteger upperBound;
    
    //e.g. you get the first 3 toppings free, but
    //they cost $0.25 for each topping afterwards
    NSInteger numberOfFreeChoices;
    
    //Special accessors will have to be used to manage choiceList
    NSMutableArray *choiceList;   
    
}

@property (retain) NSString *name;
@property (retain) NSMutableArray *choiceList;
@property (retain) NSMutableArray *selectedChoices;
@property NSInteger lowerBound;
@property NSInteger upperBound;
@property NSInteger numberOfFreeChoices;

-(id)init;

-(NSString *) description;

-(NSInteger) totalPrice;

-(NSMutableArray *) selectedChoices;

-(void) addPossibleChoice:(Choice *) aChoice;

-(BOOL) selectChoice:(Choice *) aChoice;

-(void) deselectChoice:(Choice *) aChoice;

-(BOOL) toggleChoice:(Choice *) aChoice;

-(BOOL) selectChoiceByIndex:(NSInteger) aChoice;

-(void) deselectChoiceByIndex:(NSInteger) aChoice;

-(BOOL) toggleChoiceByIndex:(NSInteger) aChoice;

-(void) updatePrices;
@end
