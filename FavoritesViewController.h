//
//  FavoritesViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FavoritesView;
@class FavoritesRenderer;
@class Menu;

@interface FavoritesViewController : UITableViewController <UITableViewDelegate>
{
    Menu *currentMenu;
    NSMutableArray *favoritesList;
    FavoritesView *favoritesView;
    FavoritesRenderer *favoritesRenderer;
    
}

-(FavoritesViewController *)initWithFavoritesListAndMenu:(NSMutableArray *)favList:(Menu *)aMenu;

@end
