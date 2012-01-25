//
//  FavoritesViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderManagementDelegate.h"
@class FavoritesView;
@class FavoritesRenderer;
@class Menu;


@interface FavoritesViewController : UITableViewController <UITableViewDelegate,OrderManagementDelegate>
{
    Menu *currentMenu;
    NSMutableArray *favoritesList;
    FavoritesView *favoritesView;
    FavoritesRenderer *favoritesRenderer;
    id<OrderManagementDelegate> delegate;
    
}

@property (retain) id<OrderManagementDelegate> delegate;

-(FavoritesViewController *)initWithFavoritesListAndMenu:(NSMutableArray *)favList:(Menu *)aMenu;

@end
