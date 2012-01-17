//
//  Order.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface Order : NSObject {

    //Contains the list of items that the customer wants to order.
    NSMutableArray *itemList; 
    
    NSString *status;
    
    NSString *orderIdentifier;
    
}

@property (retain, readonly) NSMutableArray* itemList;

-(id)init;

-(NSString *)description;

-(void) addItem:(Item *) anItem;

-(void) removeItem:(Item *) anItem;

-(NSInteger) totalPrice;

@end