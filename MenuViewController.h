//
//  MenuViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponentViewController.h"
@class Menu;
@class Order;
@class MenuView;
@class MenuRenderer;
@class Item;

@interface MenuViewController : MenuComponentViewController<UITableViewDelegate> 
{
    
    Order *orderInfo;
    Menu *menuInfo;
    MenuView *menuView;
    MenuRenderer *menuRenderer;
    
}

@property (retain) Menu *menuInfo;

-(MenuViewController *)initializeWithMenuAndOrder:(Menu *) aMenu:(Order *) anOrder;

@end
