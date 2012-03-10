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
    
    UIViewController *returnController;
    Order *ownerOrder;
    Item *itemInfo;
    ItemView *itemView;
    ItemRenderer *itemRenderer;
    id<ItemManagementDelegate> delegate;
    
}

@property (retain) id<ItemManagementDelegate> delegate;

@property (retain) Item *itemInfo;

-(ItemViewController *)initWithItemAndOrderAndReturnController:(Item *) anItem:(Order *)anOrder:(UIViewController *) aController;

-(void) addThisItemToOrder;

-(void) itemAltered;

@end
