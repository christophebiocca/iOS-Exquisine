//
//  ItemViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponentViewController.h"
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
    
}

@property (retain) Item *itemInfo;

-(ItemViewController *)initializeWithItemAndOrderAndReturnController:(Item *) anItem:(Order *)anOrder:(UIViewController *) aController;

-(void) addThisItemToOrder;

-(void) itemAltered;

@end
