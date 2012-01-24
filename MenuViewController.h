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
@class TunnelViewController;
@class Item;

@interface MenuViewController : MenuComponentViewController<UITableViewDelegate,TunnelViewControllerDelegate> 
{
    
    Item *selectedItem;
    Order *orderInfo;
    Menu *menuInfo;
    MenuView *menuView;
    MenuRenderer *menuRenderer;
    TunnelViewController *itemCustomizationTunnel;
    
}

@property (retain) Menu *menuInfo;

-(MenuViewController *)initializeWithMenuAndOrder:(Menu *) aMenu:(Order *) anOrder;

-(void)popToOrderViewController;

-(void)enterItemTunnel:(Item *) anItem;

-(void) lastControllerBeingPushedPast:(TunnelViewController *) tunnelController;

-(void) firstControllerBeingPopped:(TunnelViewController *) tunnelController;

@end
