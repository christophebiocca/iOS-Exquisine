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

@interface Menu : MenuComponent{
    
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

@end
