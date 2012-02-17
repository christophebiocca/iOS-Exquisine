//
//  OrderRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponentRenderer.h"
@class Order;
@class Menu;
@class OrderManager;

@interface OrderRenderer : MenuComponentRenderer <UITableViewDataSource>
{
    
    OrderManager *orderManager;
    
}

-(void) orderChanged:(NSNotification *)aNotification;

-(OrderRenderer *)initWithOrderManager:(OrderManager *) anOrderManager;


@end
