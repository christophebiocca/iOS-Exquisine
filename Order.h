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

@interface Order : MenuComponent {

    //Contains the list of items that the customer wants to order.
    NSMutableArray *itemList; 
    
    NSMutableArray *nonComboItemCache;
    
    NSMutableArray *comboListCache;
    
    Menu *parentMenu;
    
    NSString *status;
    
    NSString *orderIdentifier;
    
    BOOL isFavorite;
    
}

@property (retain) NSMutableArray* itemList;
@property (retain) NSString *status;
@property (retain) NSString *orderIdentifier;
@property BOOL isFavorite;
@property(readonly)NSDecimalNumber* subtotalPrice;
@property(readonly)NSDecimalNumber* taxPrice;
@property(readonly)NSDecimalNumber* totalPrice;
@property (retain) Menu *parentMenu;

-(id)init;

-(id)initFromOrder:(Order *)anOrder;

-(NSString *)description;

-(void) addItem:(Item *) anItem;

-(void) removeItem:(Item *) anItem;

-(void)removeListOfItems:(NSMutableArray *)aListOfItems;

-(NSMutableArray *) listOfCombos;

-(NSMutableArray *) listOfNonComboItems;

-(NSDictionary*)orderRepresentation;

-(void) resetCache;

@end