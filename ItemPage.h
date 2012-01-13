//
//  ItemPage.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Item;
@class ItemPageView;
@class ConfigurableTableViewDataSource;

@interface ItemPage : UIViewController<UITableViewDelegate>{
    
    ConfigurableTableViewDataSource *itemTableDataSource;
    ItemPageView *itemPageView;
    Item *currentItem;
}

@property (retain) Item *currentItem;

-(void)initializeViewWithItem:(Item *)anItem;

@end
