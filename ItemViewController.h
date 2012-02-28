//
//  ItemViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponentViewController.h"

@protocol ItemManagementDelegate;

@class Item;
@class ItemView;
@class ItemRenderer;
@class Order;

@interface ItemViewController :UITableViewController<UITableViewDelegate>
{
    
    int numberOfItems;
    UIViewController *returnController;
    Order *ownerOrder;
    Item *itemInfo;
    ItemView *itemView;
    ItemRenderer *itemRenderer;
    id<ItemManagementDelegate> delegate;
    
}

@property (retain) id<ItemManagementDelegate> delegate;

@property (retain) Item *itemInfo;

-(ItemViewController *)initializeWithItemAndOrderAndReturnController:(Item *) anItem:(Order *)anOrder:(UIViewController *) aController;

-(void) plusButtonPressed;

-(void) minusButtonPressed;

-(void) addThisItemToOrder;

-(void) itemAltered;

@end
