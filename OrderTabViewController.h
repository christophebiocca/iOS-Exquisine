//
//  OrderTabViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Order;
@class OrderTabView;
@class ShinyOrderTabRenderer;

@interface OrderTabViewController : UIViewController <UITableViewDelegate>
{
    Order *theOrder;
    OrderTabView *orderView;
    ShinyOrderTabRenderer *orderRenderer;
    
}

-(id) initWithOrder:(Order *) anOrder;

@end
