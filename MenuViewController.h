//
//  MenuViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponentViewController.h"
#import "ItemManagementDelegate.h"

@class Menu;
@class Order;
@class OrderViewController;
@class MenuView;
@class MenuRenderer;
@class Item;

@interface MenuViewController : MenuComponentViewController <UITableViewDelegate, ItemManagementDelegate> 
{
    
    OrderViewController *orderViewController;
    Order *orderInfo;
    Menu *menuInfo;
    MenuView *menuView;
    MenuRenderer *menuRenderer;
    
}

@property (retain) Menu *menuInfo;

-(MenuViewController *)initializeWithMenuAndOrderAndOrderViewController:(Menu *) aMenu:(Order *) anOrder:(OrderViewController *)anOrderViewController;

@end
