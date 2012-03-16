//
//  OrderTabViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderManager;
@class OrderTabView;
@class ShinyOrderTabRenderer;

@interface OrderTabViewController : UIViewController <UITableViewDelegate>
{
    NSArray *tempArray;
    OrderManager *theOrderManager;
    OrderTabView *orderView;
    ShinyOrderTabRenderer *orderRenderer;
    
}

-(id) initWithOrderManager:(OrderManager *) anOrderManager;

@end
