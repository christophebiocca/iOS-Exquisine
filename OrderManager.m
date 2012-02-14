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
    
    return self;
}

- (OrderManager *)initWithCoder:(NSCoder *)decoder
{
    
    thisOrder = [decoder decodeObjectForKey:@"order"];
    thisMenu = [decoder decodeObjectForKey:@"menu"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recalculate:) name:ORDER_MODIFIED object:thisOrder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(redrawNotify:) name:ORDER_FAVORITE_MODIFIED object:thisOrder];
    
    if ((!thisOrder) || (!thisMenu))
    {
        CLLog(LOG_LEVEL_ERROR, [NSString stringWithFormat: @"OrderManager failed to load properly from harddisk: \n%@" , self]);
    }
    
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

+(NSArray*)optimalCombosFromChoices:(NSArray*)combos withItems:(NSArray*)items usingCache:(NSMutableDictionary*)cache{
    NSMutableArray* applicable = [NSMutableArray arrayWithCapacity:[combos count]];
    NSArray* cached = [cache objectForKey:items];
    if(cached){
        return cached;
    }
    for(Combo* combo in combos){
        Combo* optimal = [combo optimalPickFromItems:items];
        if(optimal){
            [applicable addObject:optimal];
        }
    }
    NSArray* bestPick = [NSArray array];
    NSDecimalNumber* bestSavings = [NSDecimalNumber minimumDecimalNumber];
    for(Combo* combo in applicable){
        NSArray* optimalRemainder;
        {
            NSMutableArray* remainingItems = [NSMutableArray arrayWithArray:items];
            [remainingItems removeObjectsInArray:[combo listOfAssociatedItems]];
            optimalRemainder = [self optimalCombosFromChoices:applicable withItems:remainingItems usingCache:cache];
        }
        NSDecimalNumber* savings = [combo savings];
        for(Combo* other in optimalRemainder){
            savings = [savings decimalNumberByAdding:[other savings]];
        }
        if([savings compare:bestSavings] == NSOrderedDescending){
            bestPick = [optimalRemainder arrayByAddingObject:combo];
        }
    }
    [cache setObject:bestPick forKey:items];
    return bestPick;
}

+(NSArray*)optimalCombosFromChoices:(NSArray*)combos withItems:(NSArray*)items{
    return [self optimalCombosFromChoices:combos withItems:items usingCache:[NSMutableDictionary dictionary]];
}

//This is where everything has to happen that determines which combos apply to the order.
-(void)recalculate:(NSNotification *)aNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ORDER_MANAGER_NEEDS_REDRAW object:self];
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
