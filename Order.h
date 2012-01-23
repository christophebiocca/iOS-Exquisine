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

@interface Order : MenuComponent {

    //Contains the list of items that the customer wants to order.
    NSMutableArray *itemList; 
    
    NSString *status;
    
    NSString *orderIdentifier;
    
    BOOL isFavorite;
    
}

@property (retain, readonly) NSMutableArray* itemList;
@property (retain) NSString *status;
@property (retain) NSString *orderIdentifier;
@property BOOL isFavorite;

-(id)init;

-(id)initFromOrder:(Order *)anOrder;

-(NSString *)description;

-(void) addItem:(Item *) anItem;

-(void) removeItem:(Item *) anItem;

-(NSInteger) totalPrice;

@end