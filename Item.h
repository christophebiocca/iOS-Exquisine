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
    
    NSInteger basePriceCents;
    NSMutableArray *options;
    
}

@property (retain, readonly) NSMutableArray *options; 
@property NSInteger basePriceCents;

-(NSString *)description;

-(Item *)initFromData:(NSData *) inputData;

-(Item *)init;

-(void) addOption:(Option *) anOption;

-(NSInteger)totalPrice;

@end

