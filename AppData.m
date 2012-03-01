//
//  AppData.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppData.h"
#import "Menu.h"
#import "Order.h"
#import "OrderManager.h"
#import "LocationState.h"
#import "GetMenu.h"
#import "Reachability.h"
#import "Location.h"
#import "GetLocations.h"

NSString* INITIALIZED_SUCCESS = @"INITIALIZED_SUCCESS";
NSString* INITIALIZED_FAILURE = @"INITIALIZED_FAILURE";
NSString* SERVER_INIT_FAILURE = @"SERVER_INIT_FAILURE";

NSString* harddiskFileName = @"MainPageViewControllerInfo.plist";
NSString* harddiskFileFolder = @"~/Library/Application Support/PitaFactoryFiles/";

@implementation AppData

@synthesize initialized;
@synthesize theMenu;
@synthesize currentOrder;
@synthesize theOrderManager;
@synthesize locationState;
@synthesize ordersHistory;
@synthesize favoriteOrders;

+(void)initialize
{
    harddiskFileFolder = [harddiskFileFolder stringByExpandingTildeInPath];
}

-(id)init
{
    self = [super init];
    if (self) {
        
        initialized = NO;
        if ([self loadDataFromDisk]) {
            initialized = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:INITIALIZED_SUCCESS object:self];
        }
        else
        {
            currentOrder = [[Order alloc] init];
            theOrderManager = [[OrderManager alloc] init];
            [theOrderManager setOrder:currentOrder];
            
            ordersHistory = [[NSMutableArray alloc] initWithCapacity:0];
            favoriteOrders = [[NSMutableArray alloc] initWithCapacity:0];
        }
        
        networkChecker = [Reachability reachabilityWithHostname:(@"croutonlabs.com")];
        [networkChecker startNotifier];
        
        [self initializeFromServer];
        [self performSelector:@selector(assessInitFailure) withObject:nil afterDelay:5];
        
    }
    return self;
}

-(BOOL)loadDataFromDisk
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath: harddiskFileFolder])
    {
        NSString *path = [harddiskFileFolder stringByAppendingPathComponent: harddiskFileName];
        
        NSDictionary* rootObject;
        rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        return [self initializeFromData:rootObject];
    }
    
    return NO;
}

-(BOOL)initializeFromData:(NSDictionary *)data
{
    theMenu = [data valueForKey:@"menu"];
    currentOrder = [data valueForKey:@"current_order"];
    
    theOrderManager = [[OrderManager alloc] init];
    [theOrderManager setMenu:theMenu];
    [theOrderManager setOrder:currentOrder];
    
    locationState = [data valueForKey:@"locationState"];
    
    ordersHistory = [data valueForKey:@"order_history"];
    favoriteOrders = [data valueForKey:@"favorite_orders"];
    
    if (!(theMenu && currentOrder && theOrderManager && locationState && favoriteOrders)) {
        CLLog(LOG_LEVEL_ERROR, @"initializeFromData failed");
        return NO;
    }
    return YES;
    
    //Some notification stuff will have to be set up so that views know what to do and when
    //to update.
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCreateButtonState) name:ORDER_MANAGER_NEEDS_REDRAW object:theOrderManager];
}


-(void)saveDataToDisk
{
    //Create the folder if it's not there already
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:harddiskFileFolder withIntermediateDirectories:YES attributes:nil error:nil];

    NSString *path = [harddiskFileFolder stringByAppendingPathComponent: harddiskFileName];
  
    [NSKeyedArchiver archiveRootObject: [self recompactDataForStorage] toFile: path];
    
}

-(NSDictionary *)recompactDataForStorage
{
    NSMutableDictionary *storageDict = [NSMutableDictionary dictionary];
    
    [storageDict setValue: theMenu forKey:@"menu"];
    [storageDict setValue: currentOrder forKey:@"current_order"];
    [storageDict setValue: locationState forKey:@"locationState"];
    
    [storageDict setValue: ordersHistory forKey:@"order_history"];
    [storageDict setValue: favoriteOrders forKey:@"favorite_orders"];
    
    return storageDict;
}

-(void)initializeFromServer
{
    [self initiateMenuRefresh];
    [self getLocation];
}


-(NSInteger)numberOfFavorites
{
    return [favoriteOrders count];
}

-(void)doFavoriteConsistancyCheck
{
    for (Order *eachOrder in [self allKnownOrders]) {
        [eachOrder setFavorite:NO];
        for (Order *favOrder in favoriteOrders) {
            if([eachOrder isEffectivelyEqual:favOrder])
            {
                [eachOrder setFavorite:YES];
                break;
            }
        }
    }
}

-(NSArray *)allKnownOrders 
{
    NSMutableArray *returnList = [[NSMutableArray alloc] initWithCapacity:0];
    
    if ([ordersHistory count] > 0)
    {
        [returnList addObject:[ordersHistory lastObject]];
    }
    
    if (currentOrder)
        [returnList addObject:currentOrder];
    
    return returnList;
}

-(Order *)dereferenceOrderIdentifier:(NSString *)orderIdentifier
{
    for ( Order *eachOrder in [self allKnownOrders]) 
    {
        if ([eachOrder.orderIdentifier isEqualToString:orderIdentifier])
            return eachOrder;
    }
    return nil;
}

-(void)initiateMenuRefresh
{
    [GetMenu getMenuForRestaurant:RESTAURANT_ID
                          success:^(GetMenu* menuCall){
                              theMenu = [menuCall menu];
                              [theOrderManager setMenu:theMenu];
                              if (locationState)
                              {
                                  initialized = true;
                                  [[NSNotificationCenter defaultCenter] postNotificationName:INITIALIZED_SUCCESS object:self];
                              }
                          }
                          failure:^(GetMenu* menuCall, NSError* error){
                              if(!theMenu){
                                  /*[[[UIAlertView alloc] initWithTitle:@"No internet access"
                                                              message:@"An internet connection is required to "
                                    @"load the menu the first time this app runs."
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil] show];*/
                              } else {
                                  
                              }
                              CLLog(LOG_LEVEL_WARNING, [NSString stringWithFormat: @"call %@ errored with %@", menuCall, error]);
                          }];  
}

-(BOOL)hasServerConnection
{
    return [networkChecker isReachable];
}

-(BOOL)locationIsOpen
{
    for (Location *eachLocation in [locationState locations]) {
        if ([eachLocation storeState] == Open)
            return YES;
    }
    return NO;
}


-(void)getLocation
{
    [GetLocations getLocationsForRestaurant:RESTAURANT_ID 
                                    success:^(GetLocations* call) {
                                        if (locationState) {
                                            [locationState setLocations:[call locations]];
                                        }
                                        else
                                        {
                                            locationState = [[LocationState alloc] initWithLocations:[call locations]];
                                        }
                                        if (theMenu) {
                                            initialized = YES;
                                            [[NSNotificationCenter defaultCenter] postNotificationName:INITIALIZED_SUCCESS object:self];
                                        }
                                    }
                                    failure:^(GetLocations* call, NSError* error) {
                                        CLLog(LOG_LEVEL_WARNING ,[NSString stringWithFormat: @"Can't fetch locations:\n%@", error]);
                                    }];
}

-(void)updateOrderHistory
{
    for (Order *eachOrder in ordersHistory) 
    {
        if ([[eachOrder pitaFinishedTime] compare:[NSDate dateWithTimeIntervalSinceNow:0]] == NSOrderedAscending)
        {
            [eachOrder setComplete];
        }
    }
}

-(void) assessInitFailure
{
    if (!initialized) {
        [[NSNotificationCenter defaultCenter] postNotificationName:INITIALIZED_FAILURE object:self];
    }
}

@end
