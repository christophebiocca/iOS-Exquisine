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
{
    Order *orderInfo;
    
    //This guy contains stuff that we need
    //to display cells for after the item list.
    NSMutableArray *suffixList;
    
    //This actually expects a list of lists such that the members of the internal lists
    //respond to configureCell. Do not break this contract!
    NSMutableArray *displayLists;
    
    NSMutableArray *itemRenderList;
    
    NSMutableArray *comboRenderList;
}

-(OrderSummaryRenderer *)initWithOrder:(Order *)anOrder;

@end
