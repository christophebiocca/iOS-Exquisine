//
//  MainPage.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APICallDelegate.h"
#import "OrderManagementDelegate.h"

@class MainPageView;
@class Menu;
@class Order;

@interface MainPageViewController : UIViewController<UITableViewDelegate, OrderManagementDelegate>{
    
    BOOL internetActive;
    
    MainPageView *mainPageView;
    
    Menu *theMenu;
    Order *currentOrder;
    NSMutableArray *ordersHistory;
    NSMutableArray *favoriteOrders;
    
}

-(NSMutableArray *) pendingOrders;

-(void) favoritesButtonPressed;

-(void) pendingButtonPressed;

-(void) loadDataFromDisk;

-(void) saveDataToDisk;

-(NSString *) dataFilePath;

-(void) doFavoriteConsistancyCheck;

-(NSArray *) allKnownOrders;

@end
