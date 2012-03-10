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
#import "AutomagicalCoder.h"

@class Location;
@class MainPageView;
@class Menu;
@class Order;
@class Reachability;
@class OrderManager;
@class LocationState;

@interface MainPageViewController : UIViewController<UITableViewDelegate, OrderManagementDelegate>{
    MainPageView *mainPageView;
    
}

-(NSMutableArray *) pendingOrders;

-(void) favoritesButtonPressed;

-(void) pendingButtonPressed;

-(void) updateCreateButtonState;

-(void) updatePendingButtonState;

-(void) settingsButtonPressed;

-(void) initiateMenuRefresh;

-(void) getLocation;

-(void) updateOrderHistory;

-(void) createOrderPressed;

-(void) updateStoreHourInfo;

-(void) resetApplicationBadgeNumber;

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;

@end
