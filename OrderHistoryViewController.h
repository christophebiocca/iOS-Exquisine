//
//  OrderHistoryViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderHistoryRenderer;
@class OrderHistoryView;

@interface OrderHistoryViewController : UIViewController<UITableViewDelegate>
{
    OrderHistoryView *orderHistoryView;
    OrderHistoryRenderer *orderHistoryRenderer;
}

@end
