//
//  ShinyOrderSummaryViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShinyOrderSummaryView;
@class OrderSummaryPageRenderer;
@class Order;

@interface ShinyOrderSummaryViewController : UIViewController<UITableViewDelegate>
{
    Order *theOrder;
    ShinyOrderSummaryView *orderSummaryView;
    OrderSummaryPageRenderer *orderSummaryRenderer;
}

-(id)initWithOrder:(Order *) anOrder;

@end
