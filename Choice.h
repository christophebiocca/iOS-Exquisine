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
    
    BOOL selected;
}

@property (retain, readonly) NSDecimalNumber* price;
@property (readonly) BOOL selected;
@property (readonly) BOOL isFree;

-(Choice *)initFromChoice:(Choice *) aChoice option:(Option*)opt;

-(Choice *)initFromData:(NSDictionary *) inputData option:(Option*)opt;

-(NSString *)description;

-(NSComparisonResult)comparePrice:(Choice*)other;

@end
