//
//  Order.m
//  AvocadoTest1
//
//  Created by Jake Nielsen on 12-01-11.
//  Copyright (c) 2012 __Avocado Software__. All rights reserved.
//

//  An order contains all of the information needed to represent an abstract order that someone could
//  Make to a store
#import "Order.h"
#import "Item.h"

@implementation Order
    
@synthesize itemList;
@synthesize status,orderIdentifier;

-(id)init{
    self = [super init];
    
    name = @"New Order";
    itemList = [[NSMutableArray alloc] initWithCapacity:0];
    status = @"Not yet submitted";
    
    return self;
}

-(NSString *)description{
        
    return [NSString stringWithFormat:@"Items: \n%@" , [itemList description]];
}

-(void)addItem:(Item *)anItem{
    
    [itemList addObject:anItem];

}

-(void)removeItem:(Item *)anItem{
    [itemList removeObject:anItem];
}

-(NSInteger)totalPrice{
    NSInteger tabulator = 0;
    
    for (Item *currentItem in itemList) {
        tabulator += [currentItem totalPrice];
    }
    
    return tabulator;
}

@end
