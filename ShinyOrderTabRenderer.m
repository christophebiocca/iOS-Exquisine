//
//  ShinyOrderTabRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyOrderTabRenderer.h"
#import "OrderSectionFooterView.h"
#import "OrderSectionHeaderView.h"
#import "MenuSectionHeaderView.h"
#import "ItemGroup.h"
#import "OrderManager.h"
#import "Order.h"
#import "Combo.h"
#import "Item.h"
#import "Menu.h"

@implementation ShinyOrderTabRenderer

-(id)initWithOrderManager:(OrderManager *)anOrderManager
{
    self = [super init];
    
    if(self)
    {
        
        theOrderManager = anOrderManager;
        
        sectionNames = [[NSMutableArray alloc] init];
        listData = [[NSMutableArray alloc] init]; 
        
        [sectionNames addObject:@"Order"];
        [listData addObject:[NSArray array]];
        
        [sectionNames addObject:@"Menu"];
        NSMutableArray *menuSectionContents = [[NSMutableArray alloc] init];
        
        [menuSectionContents addObject:[MenuSectionHeaderView new]];
        
        for (id object in [[theOrderManager thisMenu] submenuList]) {
            if ([object isKindOfClass:[Item class]]) {
                NSMutableDictionary *newDictionary = [[NSMutableDictionary alloc] init];
                [newDictionary setObject:object forKey:@"menuItem"];
                [menuSectionContents addObject:newDictionary];
            }
            if ([object isKindOfClass:[Menu class]]) {
                NSMutableDictionary *newDictionary = [[NSMutableDictionary alloc] init];
                [newDictionary setObject:object forKey:@"menu"];
                [menuSectionContents addObject:newDictionary];
            }
        }
        
        [listData addObject:menuSectionContents];
        [self updateOrderSection];
    }
    
    return self;
}

-(void) updateOrderSection
{
    int index = 0;
    NSMutableArray *orderSectionContents = [[NSMutableArray alloc] initWithCapacity:0];
    
    if ([[[theOrderManager thisOrder] itemList] count] + [[[theOrderManager thisOrder] comboList] count]) {
        //If the order actually has anything in it.
        //if it doesn't, then there escentially wont be an order section at all.
        [orderSectionContents addObject:[OrderSectionHeaderView new]];
        
        for (Combo *eachCombo in [[theOrderManager thisOrder] comboList]) {
            NSMutableDictionary *newDictionary = [[NSMutableDictionary alloc] init];
            
            [newDictionary setObject:eachCombo forKey:@"combo"];
            [newDictionary setObject:[NSNumber numberWithInt:index] forKey:@"index"];
            [orderSectionContents addObject:newDictionary];
            index++;
            
            for (ItemGroup *eachItemGroup in [eachCombo listOfItemGroups]) {
                NSMutableDictionary *anotherDictionary = [[NSMutableDictionary alloc] init];
                Item *anItem = [eachItemGroup satisfyingItem];
                [anotherDictionary setObject:anItem forKey:@"orderComboItem"];
                [anotherDictionary setObject:[NSNumber numberWithInt:index] forKey:@"index"];
                [anotherDictionary setObject:@"orderCombo" forKey:@"context"];
                [orderSectionContents addObject:anotherDictionary];
                index++;
            }
            
        }
        
        for (Item *anItem in [[theOrderManager thisOrder] itemList]) {
            NSMutableDictionary *anotherDictionary = [[NSMutableDictionary alloc] init];
            [anotherDictionary setObject:anItem forKey:@"orderItem"];
            [anotherDictionary setObject:[NSNumber numberWithInt:index] forKey:@"index"];
            [anotherDictionary setObject:@"order" forKey:@"context"];
            [orderSectionContents addObject:anotherDictionary];
            index++;
        }
        
        [orderSectionContents addObject:[OrderSectionFooterView new]];
    }
    
    [listData replaceObjectAtIndex:0 withObject:orderSectionContents];
    
}

@end