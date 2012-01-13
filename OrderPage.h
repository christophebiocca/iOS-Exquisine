//
//  OrderPage.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Order;
@class OrderPageView;
@class ConfigurableTableViewDataSource;

@interface OrderPage : UIViewController<UITableViewDelegate>{

    ConfigurableTableViewDataSource *orderTableDataSource;
    OrderPageView *orderPageView;
    Order *currentOrder;
    
}

@property (retain) Order *currentOrder;

-(void)initializeViewWithOrder:(Order *) anOrder;

@end
