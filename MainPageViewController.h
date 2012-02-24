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
@class LocationState;

@interface MainPageViewController : UIViewController<UITableViewDelegate, OrderManagementDelegate>{
    
    Reachability *networkChecker;
    
    MainPageView *mainPageView;
    
    Menu *theMenu;
    Order *currentOrder;
    OrderManager *theOrderManager;
    
    NSMutableArray *ordersHistory;
    NSMutableArray *favoriteOrders;
    LocationState *locationState;
    
    NSString* harddiskFileName;
    NSString* harddiskFileFolder;
    
}

-(NSMutableArray *) pendingOrders;

-(void) favoritesButtonPressed;

-(void) pendingButtonPressed;

-(void) loadDataFromDisk;

-(void) saveDataToDisk;

-(void) doFavoriteConsistancyCheck;

-(NSArray *) allKnownOrders;

-(Order *)dereferenceOrderIdentifier:(NSString *) orderIdentifier;

-(void) updateCreateButtonState;

-(void) updatePendingButtonState;

-(void) locationButtonPressed;

-(void) initiateMenuRefresh;

-(void) getLocation;

-(void) updateOrderHistory;

-(void) createOrderPressed;

-(void) updateStoreHourInfo;

-(void) resetApplicationBadgeNumber;

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;

@end
