//
//  FavoritesRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Renderer.h"
@class Menu;

@interface FavoritesRenderer : Renderer <UITableViewDataSource>
{
    Menu *theMenu;
    
    NSMutableArray *favoriteOrders;
}

-(FavoritesRenderer *)initWithOrderListAndMenu:(NSMutableArray *)anOrderList:(Menu *)aMenu;

@end
