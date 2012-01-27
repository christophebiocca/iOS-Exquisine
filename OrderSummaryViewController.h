//
//  OrderSummaryViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Order;
@class OrderView;
@class OrderSummaryRenderer;

@interface OrderSummaryViewController : UITableViewController <UITableViewDelegate, UIActionSheetDelegate,UIAlertViewDelegate>
{
    
    Order *orderInfo;
    OrderView *orderView;
    OrderSummaryRenderer *orderSummaryRenderer;  
    UIBarButtonItem *optionsButton;
    
}

@property (retain) Order *orderInfo;

-(OrderSummaryViewController *)initializeWithOrder:(Order *) anOrder;

-(void) displayOptions;

@end
