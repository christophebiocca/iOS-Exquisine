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

extern NSString* CHOICE_PRICE_CHANGED;
extern NSString* CHOICE_SELECTED_CHANGED;
extern NSString* CHOICE_FREE_CHANGED;
extern NSString* CHOICE_CHANGED;

@interface Choice : MenuComponent
{
    
    @protected
    NSDecimalNumber* basePrice;
    BOOL selected;
    BOOL isFree;
    
}

@property (readonly) BOOL selected;
@property (readonly) BOOL isFree;

- (Choice *)initFromData:(NSDictionary *) inputData option:(Option*)anOption;

- (MenuComponent *)initWithCoder:(NSCoder *)decoder;

- (void)encodeWithCoder:(NSCoder *)encoder;

- (Choice *)copy;

- (void)setBasePrice:(NSDecimalNumber *)aPrice;

- (void)setSelected:(BOOL)isSelected;

- (void)toggleSelected;

- (void)setIsFree:(BOOL)free;

- (NSDecimalNumber *)price;

- (NSComparisonResult)comparePrice:(Choice*)other;

- (BOOL)isEffectivelyEqual:(id)aChoice;

- (NSDictionary*)orderRepresentation;

- (NSString *)descriptionWithIndent:(NSInteger) indentLevel;

@end
