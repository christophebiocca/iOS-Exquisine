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
#import "Menu.h"
#import "Combo.h"

@implementation Order
    
@synthesize itemList;
@synthesize status,orderIdentifier;
@synthesize isFavorite;
@synthesize parentMenu;

-(id)init{
    self = [super init];
    
    name = @"My Order";
    itemList = [[NSMutableArray alloc] initWithCapacity:0];
    nonComboItemCache = nil;
    comboListCache = nil;
    status = @"Not yet submitted";
    isFavorite = NO;
    
    return self;
}

-(id)initFromOrder:(Order *)anOrder
{
    nonComboItemCache = nil;
    comboListCache = nil;
    
    self = [super initFromMenuComponent:anOrder];
    
    name = anOrder.name;
    itemList = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (Item *anItem in anOrder.itemList) {
        [itemList addObject:[[Item alloc]initFromItem:anItem]];
    }
    
    parentMenu = anOrder.parentMenu;
    
    status = anOrder.status;
    isFavorite = anOrder.isFavorite;
    
    return self;
}

-(NSString *)description{
        
    return [NSString stringWithFormat:@"Items: \n%@" , [itemList description]];
}

-(void)addItem:(Item *)anItem{
    
    [itemList addObject:anItem];
    [self resetCache];


}

-(void)removeItem:(Item *)anItem{
    [itemList removeObject:anItem];
    [self resetCache];

}

-(void)removeListOfItems:(NSMutableArray *)aListOfItems
{
    for (Item *anItem in aListOfItems) {
        [self removeItem:anItem];
    }
    [self resetCache];
}


-(NSMutableArray *)listOfCombos
{
    if(comboListCache == nil)
    {
        NSMutableArray *returnList = [[NSMutableArray alloc] initWithCapacity:0];
        Order *mutableOrder = [[Order alloc] initFromOrder:self];
        
        for (Combo *aCombo in parentMenu.comboList) {
            if([aCombo evaluateForCombo:mutableOrder])
            {
                [returnList addObject:aCombo];
                [mutableOrder removeListOfItems:[aCombo listOfAssociatedItems]];
            }
        }
        nonComboItemCache = mutableOrder.itemList;
        comboListCache = returnList;
        return returnList;
    }
    return comboListCache;
}

-(NSMutableArray *)listOfNonComboItems
{
    if (nonComboItemCache == nil)
    {
        [self listOfCombos];
    }
    return nonComboItemCache;
}

-(NSDecimalNumber*)subtotalPrice
{
    NSDecimalNumber* tabulator = [NSDecimalNumber zero];
    for (Item *currentItem in [self listOfNonComboItems]) 
    {
        tabulator = [tabulator decimalNumberByAdding:[currentItem totalPrice]];
    }
    
    for (Combo *currentCombo in [self listOfCombos]) 
    {
        tabulator = [tabulator decimalNumberByAdding:[currentCombo price]];
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

-(void)resetCache
{
    nonComboItemCache = nil;
    comboListCache = nil;
}

-(void)clearOrder
{
    [itemList removeAllObjects];
    [self resetCache];
}

@end
