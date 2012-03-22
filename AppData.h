//
//  AppData.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Menu;
@class Order;
@class OrderManager;
@class LocationState;
@class Reachability;

extern NSString* INITIALIZED_SUCCESS;
extern NSString* INITIALIZED_FAILURE;
extern NSString* SERVER_INIT_FAILURE;

@interface AppData : NSObject
{
    Reachability *networkChecker;
    
    Menu *theMenu;
    Order *currentOrder;
    OrderManager *theOrderManager;
    LocationState *locationState;
    
    NSMutableArray *ordersHistory;
    NSMutableArray *favoriteOrders;
    
    BOOL initialized;
}

@property (readonly) BOOL initialized;
@property (retain) Menu *theMenu;
@property (retain) Order *currentOrder;
@property (retain) OrderManager *theOrderManager;
@property (retain) LocationState *locationState;
@property (retain) NSMutableArray *ordersHistory;
@property (retain) NSMutableArray *favoriteOrders;


-(BOOL) loadDataFromDisk;

-(BOOL) initializeFromData:(NSDictionary *)data;

-(void) saveDataToDisk;

-(NSDictionary *) recompactDataForStorage;

-(void) initializeFromServer;

-(void) updateOrderHistory;

-(void) initiateMenuRefresh;

-(void) getLocation;

-(void) doFavoriteConsistancyCheck;

-(NSArray *) allKnownOrders;

-(Order *)dereferenceOrderIdentifier:(NSString *) orderIdentifier;

-(NSInteger)numberOfFavorites;

@end
