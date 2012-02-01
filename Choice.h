//
//  Choice.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuComponent.h"

@class Option;

@interface Choice : MenuComponent{
    Option* option;
    
    NSDecimalNumber* price;
    
    NSString* propertiesChecksum;
}

@property (retain, readonly) NSDecimalNumber* price;
@property (readonly) BOOL selected;
@property (readonly) BOOL isFree;
@property (retain, readonly) NSString* propertiesChecksum;

-(Choice *)initFromChoice:(Choice *) aChoice option:(Option*)opt;

-(Choice *)initFromData:(NSDictionary *) inputData option:(Option*)opt;

-(NSString *)description;

-(NSComparisonResult)comparePrice:(Choice*)other;

-(NSDictionary*)orderRepresentation;

-(BOOL) isEffectivelySameAs:(Choice *) aChoice;

- (NSString *) descriptionWithIndent:(NSInteger) indentLevel;

@end
