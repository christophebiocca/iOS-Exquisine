//
//  ShinyOrderSummaryViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewController.h"
@class Order;

@interface ShinyOrderSummaryViewController : ListViewController
{
    Order *theOrder;
}

-(id)initWithOrder:(Order *) anOrder;

@end
