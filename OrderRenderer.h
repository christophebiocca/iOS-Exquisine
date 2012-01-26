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

@interface OrderRenderer : MenuComponentRenderer <UITableViewDataSource>
{
    Order *orderInfo;
    
    Menu *theMenu;
    
    //This guy contains stuff that we need
    //to display cells for after the item list.
    NSMutableArray *suffixList;
    
    //This actually expects a list of lists such that the members of the internal lists
    //respond to configureCell. Do not break this contract!
    NSMutableArray *displayLists;
    
    NSMutableArray *itemRenderList;
    
    NSMutableArray *comboRenderList;
}

-(void) redraw;

-(OrderRenderer *)initWithOrderAndMenu:(Order *)anOrder:(Menu *) aMenu;

-(UITableViewCell *) configureCell:(UITableViewCell *) aCell;

-(id) objectForCellAtIndex:(NSIndexPath *) index;

@end
