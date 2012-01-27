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
@synthesize creationDate, mostRecentSubmitDate;

-(id)initWithParentMenu:(Menu *) aMenu{
    self = [super init];
    
    creationDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0];
    
    parentMenu = aMenu;
    
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
    self = [super initFromMenuComponent:anOrder];
    
    nonComboItemCache = nil;
    comboListCache = nil;
 
    creationDate = anOrder.creationDate;
    mostRecentSubmitDate = anOrder.mostRecentSubmitDate;
    
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

-(id)initFromOrderShallow:(Order *)anOrder
{
    
    self = [super initFromMenuComponent:anOrder];
    
    nonComboItemCache = nil;
    comboListCache = nil;
    
    creationDate = anOrder.creationDate;
    mostRecentSubmitDate = anOrder.mostRecentSubmitDate;
    
    name = anOrder.name;
    itemList = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (Item *anItem in anOrder.itemList) {
        [itemList addObject:anItem];
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
}


-(NSMutableArray *)listOfCombos
{
    if(comboListCache == nil)
    {
        NSMutableArray *returnList = [[NSMutableArray alloc] initWithCapacity:0];
        Order *mutableOrder = [[Order alloc] initFromOrderShallow:self];
        
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

-(void) submit
{
    mostRecentSubmitDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0];
    [self setStatus:@"Queued"];
}

- (MenuComponent *)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        itemList = [decoder decodeObjectForKey:@"item_list"];
        parentMenu = [decoder decodeObjectForKey:@"parent_menu"];
        status = [decoder decodeObjectForKey:@"status"];
        orderIdentifier = [decoder decodeObjectForKey:@"order_identifier"];
        isFavorite = [[decoder decodeObjectForKey:@"is_favorite"] intValue];
        creationDate = [decoder decodeObjectForKey:@"creation_date"];
        mostRecentSubmitDate = [decoder decodeObjectForKey:@"most_recent_submit_date"];
        
        nonComboItemCache = nil;
        comboListCache =nil;
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Rinse and repeat this:
    [super encodeWithCoder:encoder];
    [encoder encodeObject:itemList forKey:@"item_list"];
    [encoder encodeObject:parentMenu forKey:@"parent_menu"];
    [encoder encodeObject:status forKey:@"status"];
    [encoder encodeObject:orderIdentifier forKey:@"order_identifier"];
    [encoder encodeObject:[NSString stringWithFormat:@"%i", isFavorite] forKey:@"is_favorite"];
    [encoder encodeObject:creationDate forKey:@"creation_date"];
    [encoder encodeObject:mostRecentSubmitDate forKey:@"most_recent_submit_date"];
}

@end
