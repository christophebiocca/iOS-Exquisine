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

@interface Item : MenuComponent
{
    
    NSDecimalNumber* basePrice;
    NSMutableArray *options;
    
}

@property (retain, readonly) NSMutableArray *options; 
@property (retain, readonly) NSDecimalNumber* basePrice;
@property (retain, readonly) NSDecimalNumber* price;


-(Item *)init;

-(Item *)initFromData:(NSDictionary *) inputData;

- (MenuComponent *)initWithCoder:(NSCoder *)decoder;

- (void)encodeWithCoder:(NSCoder *)encoder;

-(Item *)copy;

-(void) addOption:(Option *) anOption;

-(void) optionAltered;

-(BOOL) isEffectivelyEqual:(id) anItem;

-(NSComparisonResult) nameSort:(Item *)anItem;

-(NSComparisonResult) priceSort:(Item *)anItem;

- (NSDictionary*)orderRepresentation;

- (NSString *) reducedName;

- (NSString *) descriptionWithIndent:(NSInteger) indentLevel;


@end

