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
    
    //This price is the price of the choice assuming no special rules apply
    //(i.e. if this is one of the choices that you get free of charge)
    NSDecimalNumber* price;
    
    BOOL selected;
}

@property (retain, readonly) NSDecimalNumber* price;
@property (readonly) BOOL selected;
@property (readonly) BOOL isFree;

-(Choice *)initFromChoice:(Choice *) aChoice option:(Option*)opt;

-(Choice *)initFromData:(NSData *) inputData option:(Option*)opt;

-(NSString *)description;

-(NSComparisonResult)comparePrice:(Choice*)other;

@end
