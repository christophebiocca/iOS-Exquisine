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
    
    //This guy contains stuff that we need
    //to display cells for after the item list.
    NSMutableArray *suffixList;
    
    NSMutableArray *orderRenderList;
    
    //This actually expects a list of lists such that the members of the internal lists
    //respond to configureCell. Do not break this contract!
    NSMutableArray *displayLists;
}

-(FavoritesRenderer *)initWithOrderListAndMenu:(NSMutableArray *)anOrderList:(Menu *)aMenu;

-(void) redraw;

@end
