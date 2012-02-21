//
//  OrderSummaryRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListRenderer.h"
@class Order;

@interface OrderSummaryRenderer : ListRenderer <UITableViewDataSource>

-(OrderSummaryRenderer *)initWithOrder:(Order *)anOrder;

@end
