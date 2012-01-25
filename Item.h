//
//  Item.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuComponent.h"
@class Option;

@interface Item : MenuComponent{
    
    NSDecimalNumber* basePrice;
    NSMutableArray *options;
    
}

@property (retain, readonly) NSMutableArray *options; 
@property (retain, readonly) NSDecimalNumber* basePrice;
@property (retain, readonly) NSDecimalNumber* totalPrice;

-(NSString *)description;

-(Item *)initFromItem:(Item *)anItem;

-(Item *)initFromData:(NSData *) inputData;

-(Item *)init;

-(void) addOption:(Option *) anOption;

@end

