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

@class Location;
@class MainPageView;
@class Menu;
@class Order;
@class Reachability;
@class OrderManager;

@interface MainPageViewController : UIViewController<UITableViewDelegate, OrderManagementDelegate>{
    
    Reachability *networkChecker;
    
    MainPageView *mainPageView;
    
    Menu *theMenu;
    Order *currentOrder;
    OrderManager *theOrderManager;
    
    NSMutableArray *ordersHistory;
    NSMutableArray *favoriteOrders;
    NSArray* locations;
    NSString* harddiskFileName;
    NSString* harddiskFileFolder;
    
}

-(NSMutableArray *) pendingOrders;

-(void) favoritesButtonPressed;

-(void) pendingButtonPressed;

-(void) loadDataFromDisk;

-(void) saveDataToDisk;

-(NSString *) dataFilePath;

-(void) doFavoriteConsistancyCheck;

-(NSArray *) allKnownOrders;

-(void) updateCreateButtonState;

-(void) initiateMenuRefresh;

-(void) getLocation;

-(void) createOrderPressed;

-(void) updateStoreHourInfo;

-(Location *) currentLocation;

@end
