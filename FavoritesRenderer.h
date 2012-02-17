//
//  FavoritesRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListRenderer.h"
@class Menu;

@interface FavoritesRenderer : ListRenderer <UITableViewDataSource>
{
    NSMutableArray *favoriteOrders;
}

-(FavoritesRenderer *)initWithOrderList:(NSMutableArray *)anOrderList;

@end
