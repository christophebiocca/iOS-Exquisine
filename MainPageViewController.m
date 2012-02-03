//
//  MainPage.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainPageViewController.h"
#import "MainPageView.h"
#import "OrderViewController.h"
#import "Order.h"
#import "Menu.h"
#import "Item.h"
#import "ItemViewController.h"
#import "GetMenu.h"
#import "FavoritesViewController.h"
#import "OrderSummaryViewController.h"
#import "GetLocations.h"
#import "Reachability.h"
#import "PaymentStack.h"
#import "PaymentInfoViewController.h"
#import "IndicatorView.h"
#import "Location.h"

@implementation MainPageViewController

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    
    if (self) {
        [[self navigationItem] setTitle:@"Pita Factory"];
        //this wont yet check make sure that the prod server is actually up, just that the hostname resolves.
        //=/
        networkChecker = [Reachability reachabilityWithHostname:(@"croutonlabs.com")];

        [networkChecker startNotifier];
        
        [self initiateMenuRefresh];      
        
        [self loadDataFromDisk];
        
        if(!ordersHistory)
        {
            ordersHistory = [[NSMutableArray alloc] initWithCapacity:0];
        }
        if(!favoriteOrders)
        {
            favoriteOrders = [[NSMutableArray alloc] initWithCapacity:0];
        }
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) loadView
{
    mainPageView = [[MainPageView alloc] init];
    
    [mainPageView.createOrderButton addTarget:self action:@selector(createOrderPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [mainPageView.favoriteOrderButton addTarget:self action:@selector(favoritesButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [mainPageView.pendingOrderButton addTarget:self action:@selector(pendingButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self setView:mainPageView];
}

-(void)viewDidAppear:(BOOL)animated{
    [GetLocations getLocationsForRestaurant:RESTAURANT_ID 
                                    success:^(GetLocations* call) {
                                        locations = [call locations];
                                        [self updateStoreHourInfo];
                                    }
                                    failure:^(GetLocations* call, NSError* error) {
                                        NSLog(@"Can't fetch locations:\n%@", error);
                                    }];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)createOrderPressed{
    
    if(!theMenu)
    {
        NSLog(@"The menu had not been fetched upon clicking new order");
    }
    else
    {
        if (!currentOrder)
        {
            currentOrder = [[Order alloc] initWithParentMenu:theMenu];
        }
    }
    
    OrderViewController *orderView = [[OrderViewController alloc] initializeWithMenuAndOrder:theMenu:currentOrder];
    
    [orderView setDelegate:self];
    
    [[self navigationController] pushViewController:orderView animated:YES];
}

-(void)favoritesButtonPressed
{
    if(!theMenu)
    {
        NSLog(@"The menu had not been fetched upon clicking favorites");
    }
    FavoritesViewController *favoritesViewController = [[FavoritesViewController alloc] initWithFavoritesListAndMenu:favoriteOrders :theMenu];
    
    [favoritesViewController setDelegate:self];
    
    [[self navigationController] pushViewController:favoritesViewController animated:YES];
    
}

-(void)pendingButtonPressed
{
    Order *pendingOrder = [[self pendingOrders] lastObject];
    OrderSummaryViewController *orderSummaryController = [[OrderSummaryViewController alloc] initializeWithOrder:pendingOrder];
    [orderSummaryController setDelegate:self];
    
    [[self navigationController] pushViewController:orderSummaryController animated:YES];
}

-(NSMutableArray *)pendingOrders
{
    NSMutableArray *pendingOrderList = [[NSMutableArray alloc] initWithCapacity:0];
    for (Order *anOrder in ordersHistory) {
        if([anOrder status] != @"Done")
        {
            [pendingOrderList addObject:anOrder];
        }
    }
    return pendingOrderList;
}

-(void)submitOrderForController:(id)orderViewController
{
    if ([[orderViewController orderInfo] isEqual:currentOrder])
    {
        //Allocate a new order
        currentOrder = [[Order alloc] initWithParentMenu:theMenu];
    }
    PaymentStack* paymentStack = 
    [[PaymentStack alloc] initWithOrder:currentOrder locations:locations
                            completionBlock:^() {
                                //Push the current order on the history list
                                [ordersHistory addObject:[orderViewController orderInfo]];
                                [self dismissModalViewControllerAnimated:YES];
                            } 
                          cancellationBlock:^{
                              [self dismissModalViewControllerAnimated:YES];
                          }];
    [self presentModalViewController:[paymentStack navigationController] animated:YES];
}

-(NSInteger)numberOfFavorites
{
    return [favoriteOrders count];
}

-(void)addToFavoritesForController:(id)orderViewController
{
    
    for (Order *anOrder in favoriteOrders) {
        if (anOrder.name == [orderViewController orderInfo].name)
        {
            UIAlertView *tsktsk = [[UIAlertView alloc] initWithTitle:@"Error" message:@"An order with that name is already in the favorites list!" delegate:self cancelButtonTitle:@"OK, my bad" otherButtonTitles:nil];
            
            [tsktsk setTag:3];
            
            [tsktsk show];
            
            return;
        }
    }
    
    //if it makes it through the for loop, then we can safely add the order.
    
    [[orderViewController orderInfo] setIsFavorite:YES];
    
    //Push the current order on the favorites list
    //It's important that it be a copy. Changing the order in the favorites list shouldnt affect
    //An already submitted order.
    [favoriteOrders addObject:[[Order alloc] initFromOrder:[orderViewController orderInfo]]];
    //Allocate a new order if needed
    if ([[orderViewController orderInfo] isEqual:currentOrder])
    {
        currentOrder = [[Order alloc] initWithParentMenu:theMenu];
    }
    
    [self doFavoriteConsistancyCheck];
    
    [orderViewController viewWillAppear:YES];
    
    //Move view control to the favorites view.
    
    FavoritesViewController *favoritesViewController = [[FavoritesViewController alloc] initWithFavoritesListAndMenu:favoriteOrders :theMenu];
    
    [favoritesViewController setDelegate:self];
    
    [[self navigationController] setViewControllers:[[NSArray alloc]initWithObjects:self,favoritesViewController,orderViewController, nil] animated:YES]; 
    
}

-(void)deleteFromFavoritesForController:(id)orderViewController
{
    for (Order *anOrder in favoriteOrders) 
    {
        if([anOrder isEffectivelySameAs:[orderViewController orderInfo]])
        {
            [anOrder setIsFavorite:NO];
            [favoriteOrders removeObject:anOrder];
        }
    }
    
    //Now, it's a little strange, but we need to do a consistancy check between all of the orders
    //that we're aware of (which should be all of them, if that's no longer true, so help us god)
    
    //Due to the nature of the desired immutability of submited orders, we deep copy them when putting them
    //into the favorites list. If they become unfavorited or modified from the favorites list, we need to make sure
    //we do a consistancy check with historical orders.
    
    [self doFavoriteConsistancyCheck];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];  
    
    //We need to do this in case a favorited order was modified, but not removed.
    [self doFavoriteConsistancyCheck];
    
    if ([[self pendingOrders] count] > 0)
    {
        [mainPageView.pendingOrderButton setTitle:[NSString stringWithFormat:@"Order Status: %@" ,[[[self pendingOrders] lastObject] status]] forState:UIControlStateNormal];
        
        [mainPageView.pendingOrderButton setEnabled:YES];
    }
    else
    {
        [mainPageView.pendingOrderButton setEnabled:NO];
    }
    
    [self updateCreateButtonState];
    [self updateStoreHourInfo];
}

-(void) updateCreateButtonState
{
    if (theMenu)
    {
        if ([currentOrder.itemList count] > 0 )
        {
            [mainPageView.createOrderButton setTitle:@"Continue Order" forState:UIControlStateNormal];
        }
        else
        {
            [mainPageView.createOrderButton setTitle:@"New Order" forState:UIControlStateNormal];
        }        
        [mainPageView.createOrderButton setEnabled:YES];
    }
    else
    {
        [mainPageView.createOrderButton setEnabled:NO];
    }
}

-(NSString *)dataFilePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *folder = @"~/Library/Application Support/PitaFactoryFiles/";
    folder = [folder stringByExpandingTildeInPath];
    
    if ([fileManager fileExistsAtPath: folder] == NO)
    {
        [fileManager createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *fileName = @"MainPageViewControllerInfo.plist";
    return [folder stringByAppendingPathComponent: fileName];
}

-(void)loadDataFromDisk
{
    NSString *path = [self dataFilePath];
    NSDictionary* rootObject;
    rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];    
    theMenu = [rootObject valueForKey:@"menu"];
    currentOrder = [rootObject valueForKey:@"current_order"];
    ordersHistory = [rootObject valueForKey:@"order_history"];
    favoriteOrders = [rootObject valueForKey:@"favorite_orders"];
    
    [self updateCreateButtonState];
}

-(void)saveDataToDisk
{
    
    NSString *path = [self dataFilePath];
    NSMutableDictionary * rootObject;
    rootObject = [NSMutableDictionary dictionary];
    [rootObject setValue: theMenu forKey:@"menu"];
    [rootObject setValue: currentOrder forKey:@"current_order"];
    [rootObject setValue: ordersHistory forKey:@"order_history"];
    [rootObject setValue: favoriteOrders forKey:@"favorite_orders"];
    [NSKeyedArchiver archiveRootObject: rootObject toFile: path];
}

-(void)doFavoriteConsistancyCheck
{
    for (Order *eachOrder in [self allKnownOrders]) {
        [eachOrder setIsFavorite:NO];
        if (eachOrder == [[self pendingOrders] lastObject])
            NSLog(@"something");
        for (Order *favOrder in favoriteOrders) {
            if([eachOrder isEffectivelySameAs:favOrder])
            {
                [eachOrder setIsFavorite:YES];
                break;
            }
        }
    }
}

-(NSArray *)allKnownOrders 
{
    NSMutableArray *returnList = [[NSMutableArray alloc] initWithCapacity:0];
    
    [returnList addObjectsFromArray:ordersHistory];
    if (currentOrder)
        [returnList addObject:currentOrder];
    
    return returnList;
}

-(void)initiateMenuRefresh
{
    [GetMenu getMenuForRestaurant:RESTAURANT_ID
            success:^(GetMenu* menuCall){
                theMenu = [menuCall menu];
                [self updateCreateButtonState];
            }
            failure:^(GetMenu* menuCall, NSError* error){
                NSLog(@"call %@ errored with %@", menuCall, error);
            }];  
}

-(BOOL)hasServerConnection
{
    return [networkChecker isReachable];
}

-(void)updateStoreHourInfo
{
    if([locations count] == 0)
    {
        [[mainPageView openIndicator] setState:IndicatorViewOff];
        [[mainPageView storeHours] setText:@"Store hours: Fetching from server..."];
        return;
    }
    Location *currentLocation = [locations objectAtIndex:0]; 
    switch ([currentLocation storeState]) {
        case Open:
            [[mainPageView openIndicator] setState:IndicatorViewOn];
            break;
        case Closing:
            [[mainPageView openIndicator] setState:IndicatorViewStale];
            break;
        case Closed:
            [[mainPageView openIndicator] setState:IndicatorViewOff];
            break;
            
        default:
            break;
    }
    
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    if([currentLocation storeState] != Closed)
    {
        NSString *openTime = [formatter stringFromDate:[currentLocation opensToday]];
        NSString *closeTime = [formatter stringFromDate:[currentLocation closesToday]];
        
        [[mainPageView storeHours] setText:[NSString stringWithFormat:@"Open from %@ to %@",openTime,closeTime]];
    }
    else
    {
        NSString *openTime = [formatter stringFromDate:[currentLocation nextOpen]];
        NSString *closeTime = [formatter stringFromDate:[currentLocation nextClose]];
        [formatter setDateFormat:@"EEEE"];
        NSString *dayOfWeek = [formatter stringFromDate:[currentLocation nextClose]];
        
        [[mainPageView storeHours] setText:[NSString stringWithFormat:@"Opens %@ from %@ to %@",dayOfWeek,openTime,closeTime]];
        
    }
    
}

@end
