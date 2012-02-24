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
#import "PlaceOrder.h"
#import "PaymentInfo.h"
#import "Utilities.h"
#import "PaymentSuccessInfo.h"

NSString* ORDER_ITEMS_MODIFIED = @"CroutonLabs/OrderItemsModified";
NSString* ORDER_COMBOS_MODIFIED = @"CroutonLabs/OrderCombosModified";
NSString* ORDER_FAVORITE_MODIFIED = @"CroutonLabs/OrderCombosModified";
NSString* ORDER_MODIFIED = @"CroutonLabs/OrderModified";

@implementation Order

@synthesize isFavorite;
@synthesize itemList;
@synthesize comboList;
@synthesize status;
@synthesize orderIdentifier;
@synthesize creationDate;
@synthesize mostRecentSubmitDate;
@synthesize successInfo;
@synthesize pitaFinishedTime;

-(id)init
{
    self = [super init];
    
    name = @"My Order";
    
    isFavorite = NO;
    
    itemList = [[NSMutableArray alloc] initWithCapacity:0];
    comboList = [[NSMutableArray alloc] initWithCapacity:0];
    
    status = @"Not yet submitted";
    
    creationDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0];
    
    orderIdentifier = [Utilities uuid];
    
    return self;
}

- (MenuComponent *)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        isFavorite = [[decoder decodeObjectForKey:@"is_favorite"] intValue];
        
        itemList = [decoder decodeObjectForKey:@"item_list"];
        for (Item *anItem in itemList) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recalculate:) name:ITEM_MODIFIED object:anItem];
        }
        
        comboList = [decoder decodeObjectForKey:@"combo_list"];
        for (Combo *aCombo in comboList) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recalculate:) name:COMBO_MODIFIED object:aCombo];
        }
        
        status = [decoder decodeObjectForKey:@"status"];
        orderIdentifier = [decoder decodeObjectForKey:@"order_identifier"];
        creationDate = [decoder decodeObjectForKey:@"creation_date"];
        mostRecentSubmitDate = [decoder decodeObjectForKey:@"most_recent_submit_date"];
        successInfo = [decoder decodeObjectForKey:@"success_info"];
        
        if ((!itemList) || (!comboList) || (!status) || (!orderIdentifier) || (!creationDate))
        {
            CLLog(LOG_LEVEL_ERROR, [NSString stringWithFormat: @"Order failed to load properly from harddisk: \n%@" , self]);
        }
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Rinse and repeat this:
    [super encodeWithCoder:encoder];
    
    [encoder encodeObject:[NSString stringWithFormat:@"%i", isFavorite] forKey:@"is_favorite"];
    
    [encoder encodeObject:itemList forKey:@"item_list"];
    [encoder encodeObject:comboList forKey:@"combo_list"];
    [encoder encodeObject:status forKey:@"status"];
    [encoder encodeObject:orderIdentifier forKey:@"order_identifier"];\
    [encoder encodeObject:creationDate forKey:@"creation_date"];
    [encoder encodeObject:mostRecentSubmitDate forKey:@"most_recent_submit_date"];
    [encoder encodeObject:successInfo forKey:@"success_info"];
}


-(id)copy
{
    Order *anOrder = [[Order alloc] init];
    
    anOrder->name = name;
    anOrder->desc = desc;
    anOrder->primaryKey = primaryKey; 
    
    anOrder->isFavorite = isFavorite;
 
    for (Item *anItem in itemList) {
        Item *newItem = [anItem copy];
        [anOrder addItem:newItem];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recalculate:) name:ITEM_MODIFIED object:newItem];

    }
    
    for (Combo *aCombo in itemList) {
        Combo *newCombo = [aCombo copy];
        [anOrder addCombo:newCombo];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recalculate:) name:COMBO_MODIFIED object:newCombo];
    }
    
    anOrder->status = status;
    anOrder->orderIdentifier = orderIdentifier;
    
    creationDate = [anOrder.creationDate copy];
    mostRecentSubmitDate = [anOrder.mostRecentSubmitDate copy];

    anOrder->pitaFinishedTime = pitaFinishedTime;    
    return anOrder;
}

-(NSString *)defaultFavName
{
    NSMutableString *output = [[NSMutableString alloc] init];
    
    if ([comboList count] > 0) 
    {
        return [[comboList objectAtIndex:0] name];
    }
    
    if ([itemList count] > 0) 
    {
        [output appendString:[[itemList objectAtIndex:0] reducedName]];
        
        //lol, what a bad way to do this.
        int i = 0;
        for (Item *anItem in itemList) {
            if (!((i > 2 )||(i == 0)))
                [output appendFormat:@", %@",[anItem reducedName]];
            i++;
        }
    
    }
    return output;
}

-(BOOL)containsExactItem:(Item *)anItem
{
    for (Item *eachItem in itemList) {
        if (anItem == eachItem)
            return YES;
    }
    
    for (Combo *eachCombo in comboList) {
        if ([eachCombo containsExactItem:anItem]) {
            return YES;
        }
    }
    return NO;
}

-(NSDecimalNumber*)subtotalPrice
{
    NSDecimalNumber* tabulator = [NSDecimalNumber zero];
    for (Item *currentItem in itemList) 
    {
        tabulator = [tabulator decimalNumberByAdding:[currentItem price]];
    }
    
    for (Combo *currentCombo in comboList) 
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

-(void)addItem:(Item *)anItem{
    [itemList addObject:anItem];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recalculate:) name:ITEM_MODIFIED object:anItem];
    [self recalculate:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:ORDER_ITEMS_MODIFIED object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:ORDER_MODIFIED object:self];


}

-(void)removeItem:(Item *)anItem{
    
    for (Item *eachItem in itemList) {
        if ([anItem isEqual:eachItem]) {
            [itemList removeObject:anItem];
            [[NSNotificationCenter defaultCenter] removeObserver:self name:ITEM_MODIFIED object:anItem];
            [self recalculate:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:ORDER_ITEMS_MODIFIED object:self];
            [[NSNotificationCenter defaultCenter] postNotificationName:ORDER_MODIFIED object:self];
            return;
        }
    }
    
    //Since the item list isn't redundant with respect to the combos, the combos need to be checked as well.
    
    for (Combo *aCombo in comboList) {
        if ([aCombo containsItem:anItem]) {
            NSMutableArray* comboItems = [NSMutableArray arrayWithArray:[aCombo listOfAssociatedItems]];
            [comboItems removeObject:anItem];
            [itemList addObjectsFromArray:comboItems];
            [comboList removeObject:aCombo];
            [[NSNotificationCenter defaultCenter] removeObserver:self name:ITEM_MODIFIED object:anItem];
            [self recalculate:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:ORDER_ITEMS_MODIFIED object:self];
            [[NSNotificationCenter defaultCenter] postNotificationName:ORDER_MODIFIED object:self];
            return;
        }
    }
    
    //If we've made it here, somebody did something wrong.
    
    CLLog(LOG_LEVEL_WARNING, [NSString stringWithFormat: @"ERROR: Somebody tried to remove this item from this order, and that item isn't in this order!:\n%@\n%@",anItem,self]);

}

-(void)removeListOfItems:(NSMutableArray *)aListOfItems
{
    for (Item *anItem in aListOfItems) {
        [self removeItem:anItem];
    }
}

-(void)addCombo:(Combo *)aCombo
{
    [comboList addObject:aCombo];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recalculate:) name:COMBO_MODIFIED object:aCombo];
    [self recalculate:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:ORDER_COMBOS_MODIFIED object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:ORDER_MODIFIED object:self];

}

-(void)removeCombo:(Combo *)aCombo
{
    [comboList removeObject:aCombo];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:COMBO_MODIFIED object:aCombo];
    [self recalculate:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:ORDER_COMBOS_MODIFIED object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:ORDER_MODIFIED object:self];

}

-(void)setFavorite:(BOOL)isfav
{
    isFavorite = isfav;
    [[NSNotificationCenter defaultCenter] postNotificationName:ORDER_FAVORITE_MODIFIED object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:ORDER_MODIFIED object:self];
}

-(void)placedWithTransactionInfo:(PaymentSuccessInfo*)info
{
    // We'll also need to save up the payment info somewhere.
    successInfo = info;
    
    [self setStatus:@"Placed"];
    
    UILocalNotification *notification= [[UILocalNotification alloc] init];
    
    [notification setAlertBody:@"Your pita is ready for pickup"];
    
    [notification setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:orderIdentifier,@"order", nil]];
    
    [notification setFireDate:pitaFinishedTime];
    
    [notification setApplicationIconBadgeNumber:1];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

-(void)submit
{
    mostRecentSubmitDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0];
    [self setStatus:@"Sending"];
}

-(void)setComplete
{
    [self setStatus:@"Done"];
}

-(void)recalculate:(NSNotification *)aNotification
{
    [itemList sortUsingSelector:@selector(priceSort:)];
    [comboList sortUsingSelector:@selector(savingsSort:)];
    [[NSNotificationCenter defaultCenter] postNotificationName:ORDER_MODIFIED object:self];
}

-(BOOL)isEffectivelyEqual:(Order *)anOrder
{
    if ([[anOrder itemList] count] != [itemList count])
        return NO;
    if ([[anOrder comboList] count] != [comboList count])
        return NO;
    
    for (int i = 0; i < [comboList count] ; i++)
    {
        if (![[comboList objectAtIndex:i] isEffectivelyEqual:[[anOrder comboList] objectAtIndex:i]]) {
            return NO;
        }
        if (![[itemList objectAtIndex:i] isEffectivelyEqual:[[anOrder itemList] objectAtIndex:i]]) {
            return NO;
        }
        
    }
    for (int i = 0; i < [itemList count] ; i++)
    {
        if (![[itemList objectAtIndex:i] isEffectivelyEqual:[[anOrder itemList] objectAtIndex:i]]) {
            return NO;
        }
    }
    return YES;
}

-(NSDictionary*)orderRepresentation{
    
    NSMutableArray* orderitems = [NSMutableArray arrayWithCapacity:[itemList count]];
    for(Item* item in itemList){
        [orderitems addObject:[item orderRepresentation]];
    }
    NSMutableArray* ordercombos = [NSMutableArray arrayWithCapacity:[comboList count]];
    for(Combo* combo in comboList){
        [ordercombos addObject:[combo orderRepresentation]];
    }
    return [NSDictionary dictionaryWithObjectsAndKeys:
            orderitems, @"items",
            ordercombos, @"combos",
            nil];

}

- (NSString *) descriptionWithIndent:(NSInteger) indentLevel
{    
    NSString *padString = [@"" stringByPaddingToLength:(indentLevel*4) withString:@" " startingAtIndex:0];
    
    NSMutableString *output = [[NSMutableString alloc] initWithCapacity:0];
    
    [output appendFormat:@"%@Order:\n",padString];
    [output appendString:[super descriptionWithIndent:indentLevel]];
    [output appendFormat:@"%@IsFavorite: %i\n",padString,isFavorite];
    [output appendFormat:@"%@Subtotal: %@\n",padString,[self subtotalPrice]];
    [output appendFormat:@"%@Tax: %@\n",padString,[self taxPrice]];
    [output appendFormat:@"%@GrandTotal: %@\n",padString,[self totalPrice]];
    [output appendFormat:@"%@Combos:\n",padString];
    
    for (Combo *aCombo in comboList) {
        [output appendFormat:@"%@\n",[aCombo descriptionWithIndent:(indentLevel + 1)]];
    }
    
    [output appendFormat:@"%@Items:\n",padString];
    
    for (Item *anItem in itemList) {
        [output appendFormat:@"%@\n",[anItem descriptionWithIndent:(indentLevel + 1)]];
    }
    
    return output;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
