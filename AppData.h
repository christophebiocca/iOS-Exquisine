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
@class Item;
@class Combo;

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
    NSMutableArray *favoriteItems;
    NSMutableArray *favoriteCombos;
    Menu *favoritesMenu;
    
    BOOL initialized;
}

@property (readonly) BOOL initialized;
@property (retain) Reachability *networkChecker;
@property (retain) Menu *theMenu;
@property (retain) Order *currentOrder;
@property (retain) OrderManager *theOrderManager;
@property (retain) LocationState *locationState;
@property (retain) NSMutableArray *ordersHistory;
@property (retain) Menu *favoritesMenu;

+(AppData *)appData;

-(BOOL) loadDataFromDisk;

-(BOOL) initializeFromData:(NSDictionary *)data;

-(void) saveDataToDisk;

-(NSDictionary *) recompactDataForStorage;

-(void) initializeFromServer;

-(void) updateOrderHistory;

-(void) initiateMenuRefresh;

-(void) getLocation;

-(Order *)dereferenceOrderIdentifier:(NSString *) orderIdentifier;

-(BOOL) anyLocationIsOpen;

-(BOOL) isFavoriteItem:(Item *) inputItem;

-(BOOL) isFavoriteCombo:(Combo *) inputCombo;

-(void) setFavoriteItem:(Item *) inputItem;

-(void) setFavoriteCombo:(Combo *) inputCombo;

-(void) unsetFavoriteItem:(Item *) inputItem;

-(void) unsetFavoriteCombo:(Combo *) inputCombo;

-(void) toggleFavoriteItem:(Item *) inputItem;

-(void) toggleFavoriteCombo:(Combo *) inputCombo;



@end
