//
//  ItemGroupViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-01.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponentViewController.h"
#import "ItemManagementDelegate.h"

@class ItemGroup;
@class ItemGroupView;
@class ItemGroupRenderer;
@class Order;

@interface ItemGroupViewController : MenuComponentViewController<UITableViewDelegate, ItemManagementDelegate>
{
    
    UIViewController *returnController;
    Order *currentOrder;
    ItemGroup *itemGroupInfo;
    ItemGroupView *itemGroupView;
    ItemGroupRenderer *itemGroupRenderer;
    
    
}

-(ItemGroupViewController *)initWithItemGroupAndOrderAndReturnViewController:(ItemGroup *)anItemGroup:(Order *) anOrder:(UIViewController *) aViewController;

@property (retain) ItemGroup *itemGroupInfo;

@end
