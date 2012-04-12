//
//  OrderSummaryPageRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListRenderer.h"
@class Order;

@interface OrderSummaryPageRenderer : ListRenderer
{
    Order *theOrder;
}

-(id) initWithOrder:(Order *) anOrder;

@end
