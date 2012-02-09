//
//  OrderManager.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderManager.h"
#import "Order.h"
#import "Menu.h"
#import "Combo.h"

NSString* ORDER_MANAGER_NEEDS_REDRAW = @"CroutonLabs/OrderManagerNeedsRedraw";

@implementation OrderManager

@synthesize thisOrder;
@synthesize thisMenu;

-(OrderManager *)init
{
    self = [super init];
    
    thisOrder = [[Order alloc] init];
    thisMenu = [[Menu alloc] init];
    recalculating = NO;
    
    return self;
}

- (OrderManager *)initWithCoder:(NSCoder *)decoder
{
    
    thisOrder = [decoder decodeObjectForKey:@"order"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recalculate:) name:ORDER_MODIFIED object:thisOrder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(redrawNotify:) name:ORDER_FAVORITE_MODIFIED object:thisOrder];
    thisMenu = [decoder decodeObjectForKey:@"menu"];
    recalculating = NO;
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:thisOrder forKey:@"order"];
    [encoder encodeObject:thisMenu forKey:@"menu"];
}

-(OrderManager *)copy
{
    OrderManager *newOrderManager = [[OrderManager alloc] init];
    
    newOrderManager->thisOrder = [thisOrder copy];
    newOrderManager->thisMenu = [thisMenu copy];
    
    return newOrderManager;
}

-(void)setMenu:(Menu *)inputMenu
{
    thisMenu = inputMenu;
    [self recalculate:nil];
}

-(void)setOrder:(Order *)inputOrder
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ORDER_MODIFIED object:thisOrder];
    thisOrder = inputOrder;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recalculate:) name:ORDER_MODIFIED object:thisOrder];
    [self recalculate:nil];
}

//This is where everything has to happen that determines which combos apply to the order.
-(void)recalculate:(NSNotification *)aNotification
{
    //This is to avoid concurrancy issues. There may be a better way though.. idk.
    if(!recalculating)
    {
        recalculating = YES;
        if(thisMenu&&thisOrder)
        {
            //We can do some intelligent caching if this becomes expensive.
            
            //Well, I guess first we'll just grab all the items from the order in list form:
            NSMutableArray *itemsInOrder = [[NSMutableArray alloc] initWithArray:[thisOrder itemList]];
            
            for (Combo *aCombo in [thisOrder comboList]) {
                [itemsInOrder addObjectsFromArray:[aCombo listOfAssociatedItems]];
            }
            
            //Now we need all of the combos from the menu:
            NSMutableArray *allCombos = [[NSMutableArray alloc] initWithArray:[thisMenu recursiveComboList]];
            
            NSMutableArray *potentialCombos = [[NSMutableArray alloc] initWithCapacity:0];
            
            for (Combo *eachCombo in allCombos) {
                if ([eachCombo satisfiedWithItemList:itemsInOrder])
                    [potentialCombos addObject:eachCombo];
            }
            
            [potentialCombos sortUsingSelector:@selector(savingsSort:)];
            
            NSMutableArray *orderCombos = [[NSMutableArray alloc] initWithCapacity:0];
            //Now we'll apply the combos in the best possible order.
            for (Combo *eachCombo in potentialCombos) 
            {
                while ([eachCombo satisfiedWithItemList:itemsInOrder]) {
                    
                    Combo *newCombo = [eachCombo copy];
                    
                    [newCombo removeAllItems];
                    
                    for (NSMutableArray *satisfactionArray in [eachCombo satisfactionListsForItemList:itemsInOrder]) {
                        Item *satisfyingItem = [satisfactionArray objectAtIndex:0];
                        [newCombo addItem:satisfyingItem];
                        [itemsInOrder removeObject:satisfyingItem];
                    }
                    
                    [orderCombos addObject:newCombo];
                }
            }
            
            [thisOrder setItemList:itemsInOrder];
            [thisOrder setComboList:orderCombos];
            //Whew
            
            [[NSNotificationCenter defaultCenter] postNotificationName:ORDER_MANAGER_NEEDS_REDRAW object:self];
        }
        recalculating = NO;
    }
}

-(void)redrawNotify:(NSNotification *)aNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ORDER_MANAGER_NEEDS_REDRAW object:self];
}

-(BOOL)isEffectivelyEqual:(id)anOrderManager
{
    if (![anOrderManager isKindOfClass:[OrderManager class]])
        return NO;
    
    if (![[anOrderManager thisOrder] isEffectivelyEqual:thisOrder]) 
        return NO;
    
    if (![[anOrderManager thisMenu] isEffectivelyEqual:thisMenu]) 
        return NO;
    
    return YES;
}

- (NSString *) descriptionWithIndent:(NSInteger) indentLevel
{    
    NSString *padString = [@"" stringByPaddingToLength:(indentLevel*4) withString:@" " startingAtIndex:0];
    
    NSMutableString *output = [[NSMutableString alloc] initWithCapacity:0];
    
    [output appendFormat:@"%@OrderManager:\n",padString];
    [output appendFormat:@"%@Order: %@\n",padString,thisOrder];
    [output appendFormat:@"%@Menu: %@\n",padString,thisMenu];
    
    return output;
}

-(NSString *)description
{
    return [self descriptionWithIndent:0];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
