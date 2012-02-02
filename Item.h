//
//  Item.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuComponent.h"

extern NSString* ITEM_MODIFIED;

@class Option;

@interface Item : MenuComponent{
    
    NSDecimalNumber* basePrice;
    NSMutableArray *options;
    NSString* propertiesChecksum;
    
}

@property (retain, readonly) NSMutableArray *options; 
@property (retain, readonly) NSDecimalNumber* basePrice;
@property (retain, readonly) NSDecimalNumber* totalPrice;
@property (retain, readonly) NSString* propertiesChecksum;

-(NSString *)description;

-(Item *)initFromItem:(Item *)anItem;

-(Item *)initFromData:(NSDictionary *) inputData;

-(Item *)init;

-(void) addOption:(Option *) anOption;

-(NSDictionary*)orderRepresentation;

-(BOOL) isEffectivelySameAs:(Item*) anItem;

-(NSComparisonResult) nameSort:(Item *)anItem;

- (NSString *) descriptionWithIndent:(NSInteger) indentLevel;

-(void) optionAltered;

-(NSString *) reducedName;

@end

