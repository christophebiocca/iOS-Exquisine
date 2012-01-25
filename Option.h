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
    
    NSString* propertiesChecksum;
    
}

@property (retain,readonly) NSArray *choiceList;
@property (retain,readonly) NSArray *selectedChoices;
@property (retain,readonly) NSArray *selectedFreeChoices;
@property (readonly) NSInteger lowerBound;
@property (readonly) NSInteger upperBound;
@property (readonly) NSInteger numberOfFreeChoices;
@property (readonly) NSInteger remainingFreeChoices;
@property(retain,readonly) NSDecimalNumber* totalPrice;
@property (retain,readonly) NSString* propertiesChecksum;

-(Option *)initFromOption:(Option *)anOption;

-(Option *)initFromData:(NSDictionary *)inputData;

-(Option *)init;

-(NSString *) description;

-(void) addPossibleChoice:(Choice *) aChoice;

-(BOOL) selectChoice:(Choice *) aChoice;

-(void) deselectChoice:(Choice *) aChoice;

-(BOOL) toggleChoice:(Choice *) aChoice;

-(BOOL) selectChoiceByIndex:(NSInteger) aChoice;

-(void) deselectChoiceByIndex:(NSInteger) aChoice;

-(BOOL) toggleChoiceByIndex:(NSInteger) aChoice;
@end
