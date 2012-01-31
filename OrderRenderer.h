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
    
    //This list just contains the stuff that
    //we should be trying to make cells for in
    //the order section of the table.
    NSMutableArray *orderDisplayList;
    
}

-(void) refreshOrderList;

-(OrderRenderer *)initWithOrderAndMenu:(Order *)anOrder:(Menu *) aMenu;

-(id) objectForCellAtIndex:(NSIndexPath *) index;

- (UITableViewCell *)menuCellForIndexPath:(UITableView *) tableView:(NSIndexPath *) indexPath;

- (UITableViewCell *)itemCellForIndexPath:(UITableView *) tableView:(NSIndexPath *) indexPath;

@end
