//
//  OrderHistoryRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListRenderer.h"
@class Order;

@interface OrderHistoryRenderer : ListRenderer
{
    Order *theOrder;
}

-(id)init;

@end
