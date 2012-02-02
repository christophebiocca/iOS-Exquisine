//
//  Menu.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuComponent.h"
@class Item;
@class Order;

@interface Menu : MenuComponent{
    
    Menu *parentMenu;
    Order *associatedOrder;
    NSMutableArray *submenuList;
    NSMutableArray *comboList;
    
}

@property (retain,readonly) NSMutableArray *submenuList;
@property (retain,readonly) NSMutableArray *comboList;

-(Menu *) init;

-(void) addSubmenu:(Menu *) aSubmenu;

-(Menu *) initFromData:(NSDictionary *)inputData;

-(Item *) dereferenceItemPK:(NSInteger) itemPK;

-(Menu *) dereferenceMenuPK:(NSInteger) menuPK;

-(NSArray *) flatItemList;

-(Menu *) initFromDataAndMenu:(NSDictionary *)inputData:(Menu *) inputMenu;

-(void) setAssociatedOrder:(Order *)anOrder;

@end
