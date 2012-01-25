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
@synthesize isFavorite;

-(id)init{
    self = [super init];
    
    name = @"My Order";
    itemList = [[NSMutableArray alloc] initWithCapacity:0];
    status = @"Not yet submitted";
    isFavorite = NO;
    
    return self;
}

-(id)initFromOrder:(Order *)anOrder
{
    self = [super initFromMenuComponent:anOrder];
    
    name = anOrder.name;
    itemList = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (Item *anItem in anOrder.itemList) {
        [itemList addObject:[[Item alloc]initFromItem:anItem]];
    }
    
    status = anOrder.status;
    isFavorite = anOrder.isFavorite;
    
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


//Yes, this is pretty inefficient. No, I don't think it matters.

-(NSDecimalNumber*)subtotalPrice
{
    NSDecimalNumber* tabulator = [NSDecimalNumber zero];
    for (Item *currentItem in itemList) {
        tabulator = [tabulator decimalNumberByAdding:[currentItem totalPrice]];
    }
    return tabulator;
}

-(NSDecimalNumber*)taxPrice
{
    NSDecimalNumber* taxRate = [NSDecimalNumber decimalNumberWithString:@"0.13"];
    
    return [[self subtotalPrice] decimalNumberByMultiplyingBy:taxRate];
}


-(NSDecimalNumber*)totalPrice
{
    return [[self subtotalPrice] decimalNumberByAdding:[self taxPrice]];
}

-(NSDictionary*)orderRepresentation{
    NSMutableArray* orderitems = [NSMutableArray arrayWithCapacity:[itemList count]];
    for(Item* item in itemList){
        [orderitems addObject:[item orderRepresentation]];
    }
    return [NSDictionary dictionaryWithObject:orderitems forKey:@"items"];
}

@end
