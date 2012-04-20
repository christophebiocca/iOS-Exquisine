//
//  OrderTabViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewController.h"
@class OrderManager;

extern NSString *ORDER_PLACEMENT_REQUESTED;

@interface OrderTabViewController : ListViewController
{
    OrderManager *theOrderManager;
}

-(id) initWithOrderManager:(OrderManager *) anOrderManager;

@end
