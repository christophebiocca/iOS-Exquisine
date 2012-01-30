//
//  Order.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuComponent.h"
@class Item;
@class Menu;
@class Location;

extern NSString* ORDER_ITEMS_MODIFIED;

@interface Order : MenuComponent {

    //Contains the list of items that the customer wants to order.
    NSMutableArray *itemList; 
    
    NSMutableArray *nonComboItemCache;
    
    NSMutableArray *comboListCache;
    
    Menu *parentMenu;
    
    NSString *status;
    
    NSString *orderIdentifier;
    
    BOOL isFavorite;
    
    NSDate *creationDate;
    
    NSDate *mostRecentSubmitDate;
    
}

@property (readonly) NSDate *creationDate;
@property (readonly) NSDate *mostRecentSubmitDate;
@property (retain) NSMutableArray* itemList;
@property (retain) NSString *status;
@property (retain) NSString *orderIdentifier;
@property BOOL isFavorite;
@property(readonly)NSDecimalNumber* subtotalPrice;
@property(readonly)NSDecimalNumber* taxPrice;
@property(readonly)NSDecimalNumber* totalPrice;
@property (retain) Menu *parentMenu;

-(id)initWithParentMenu:(Menu *) aMenu;

-(id)initFromOrder:(Order *)anOrder;

-(id)initFromOrderShallow:(Order *)anOrder;

-(NSString *)description;

-(void) addItem:(Item *) anItem;

-(void) removeItem:(Item *) anItem;

-(void)removeListOfItems:(NSMutableArray *)aListOfItems;

-(NSMutableArray *) listOfCombos;

-(NSMutableArray *) listOfNonComboItems;

-(NSDictionary*)orderRepresentation;

-(void) resetCache;

-(void) clearOrder;

-(BOOL) isEffectivelySameAs:(Order *) anOrder;

-(void) submitToLocation:(Location*)location;

-(void) reSort;

@end