//
//  Option.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuComponent.h"
@class Choice;

@interface Option : MenuComponent{
    
    NSInteger lowerBound;
    NSInteger upperBound;
    
    //e.g. you get the first 3 toppings free, but
    //they cost $0.25 for each topping afterwards
    NSInteger numberOfFreeChoices;
    
    //Special accessors will have to be used to manage choiceList
    NSMutableArray *choiceList; 
    NSMutableArray *selectedChoices;
    
}

@property (retain,readonly) NSMutableArray *choiceList;
@property (retain,readonly) NSMutableArray *selectedChoices;
@property NSInteger lowerBound;
@property NSInteger upperBound;
@property NSInteger numberOfFreeChoices;

-(Option *)initFromOption:(Option *)anOption;

-(Option *)initFromData:(NSData *)inputData;

-(Option *)init;

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
