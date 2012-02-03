//
//  Option.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuComponent.h"

extern NSString* OPTION_MODIFIED;
extern NSString* OPTION_CHOICE_ADDED;
extern NSString* OPTION_CHOICE_REMOVED;
extern NSString* OPTION_INVALID_SELECTION;
extern NSString* OPTION_INVALID_DESELECTION;

@class Choice;

@interface Option : MenuComponent{
    
    NSInteger lowerBound;
    NSInteger upperBound;
    
    //e.g. you get the first 3 toppings free, but
    //they cost $0.25 for each topping afterwards
    NSInteger numberOfFreeChoices;
    
    //Special accessors will have to be used to manage choiceList
    NSMutableArray *choiceList; 
    
}

@property (retain,readonly) NSArray *choiceList;
@property (readonly) NSInteger lowerBound;
@property (readonly) NSInteger upperBound;
@property (readonly) NSInteger numberOfFreeChoices;


- (Option *)init;

- (Option *)initFromData:(NSDictionary *)inputData;

- (MenuComponent *)initWithCoder:(NSCoder *)decoder;

- (void)encodeWithCoder:(NSCoder *)encoder;

- (Option *) copy;

- (NSDecimalNumber*)price;

- (NSArray *) selectedChoices;

- (NSInteger) numberOfSelectedChoices;

- (void) addChoice:(Choice *) aChoice;

- (void) removeChoice:(Choice *) aChoice;

- (void) selectChoiceByIndex:(NSInteger) aChoice;

- (void) deselectChoiceByIndex:(NSInteger) aChoice;

- (void) toggleChoiceByIndex:(NSInteger) aChoice;

- (void) recalculate:(NSNotification *)aNotification;

- (void) validateState;

- (BOOL) isEqual:(id) anOption;

- (NSDictionary*)orderRepresentation;

- (NSString *) descriptionWithIndent:(NSInteger) indentLevel;

@end
