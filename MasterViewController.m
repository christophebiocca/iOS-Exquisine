//
//  MasterViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import "MasterView.h"
#import "LoadingView.h"
#import "LocationTabViewController.h"
#import "OrderTabViewController.h"
#import "Order.h"
#import "OrderManager.h"
#import "PaymentStack.h"
#import "SettingsTabViewController.h"
#import "AppData.h"
#import "CustomTabBarController.h"
#import "Reachability.h"

@implementation MasterViewController

@synthesize masterView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        masterView = [[MasterView alloc] initWithFrame:frame];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initializationSuccess) name:INITIALIZED_SUCCESS object:[AppData appData]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initializationFailure) name:INITIALIZED_FAILURE object:[AppData appData]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displaySpinner) name:INITIALIZING_FROM_SERVER object:[AppData appData]];
        
        (void)[[AppData appData] init];
        
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showOrderConfirmation:) name:ORDER_PLACEMENT_REQUESTED object:[[AppData appData] theOrderManager]];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self setView:masterView];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) initializationSuccess
{
    [[[masterView loadingView] progressLabel] setText:@"Initialization Complete"];
    LocationTabViewController *locationTabViewController = [[LocationTabViewController alloc] initWithLocationState:[[AppData appData] locationState]];
    
    [locationTabViewController setTitle:@"Locations"];
    [[locationTabViewController tabBarItem] setImage:[UIImage imageNamed:@"LocationIcon"]];
    
    OrderTabViewController *orderTabViewController = [[OrderTabViewController alloc] initWithOrderManager:[[AppData appData] theOrderManager]];
    
    UINavigationController *orderTabNavigationController = [[UINavigationController alloc] initWithRootViewController:orderTabViewController];
    [orderTabNavigationController setHidesBottomBarWhenPushed:YES];
    
    [orderTabNavigationController setTitle:@"Order"];
    [[orderTabNavigationController tabBarItem] setImage:[UIImage imageNamed:@"ForkAndKnife.png"]];
    
    SettingsTabViewController *settingsTabViewController = [[SettingsTabViewController alloc] init];
    
    UINavigationController *settingsTabNavigationController = [[UINavigationController alloc] initWithRootViewController:settingsTabViewController];
    
    [settingsTabNavigationController setTitle:@"Settings"];
    [[settingsTabNavigationController tabBarItem] setImage:[UIImage imageNamed:@"SettingsIcon.png"]];
    
    [[masterView tabController] setViewControllers:[NSArray arrayWithObjects:orderTabNavigationController,locationTabViewController,settingsTabNavigationController,nil]];
    
    [[[masterView tabController] view] setNeedsLayout];
    [[[masterView tabController] view] setNeedsDisplay];
    //This is here because if the app also hits the server successfully, it'll reload some stuff.
    [masterView performSelector:@selector(dissolveLoadingView) withObject:nil afterDelay:2];
}

-(void) initializationFailure
{
    [[[masterView loadingView] progressLabel] setText:@"No connectivity detected"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"You must have an internet connection the first time you run this app" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [masterView dissolveProgressIndicator];
    [alert show];
}

-(void)reloadData
{
    [masterView putUpLoadingView];
    [[AppData appData] initializeFromServer];
    [masterView performSelector:@selector(dissolveLoadingView) withObject:nil afterDelay:2];
}

-(void) showOrderConfirmation:(NSNotification *) aNotification
{
    
    if (![[aNotification object] isKindOfClass:[OrderManager class]]) 
    {
        CLLog(LOG_LEVEL_ERROR, @"An object not of type OrderManager was sent to MasterViewController's showOrderConfirmation:  omgwtfhax. That is all.");
        return;
    }
    
    if ([aNotification object] != [[AppData appData] theOrderManager]) {
        CLLog(LOG_LEVEL_ERROR, @"We're trying to submit an order with an orderManager that does not belong to appData. That's bad, and it won't work. Commencing operation run around like a chicken with its head cut off.");
        return;
    }
    
    if([[[aNotification object] thisOrder].totalPrice doubleValue] <= 0.0)
    {
        UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Oops" message:@"You havn't selected anything to purchase" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Tried to place an empty order"];
        
        [areYouSure show];
        
        return;
    }
    
    if(![[AppData appData] anyLocationIsOpen])
    {
        UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Oops" message:@"None of the restaurants are open right now. You'll have to wait until they are." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Tried to place order when the restautant isn't open"];
        
        [areYouSure show];
        
        return;
    }
    
    if([[[AppData appData] networkChecker] isReachable])
    {
        [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Placed order"];
        
        [self placeOrder:[[AppData appData] theOrderManager]];
        [[[[AppData appData] theOrderManager] thisOrder] setStatus:@"Transmitting"];
        
        return;
    }
    
    UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Oops" message:@"You appear to have no connection to the internet." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    
    [areYouSure show];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 1) // Order Placement
    {
        if (buttonIndex == 2)
            [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Canceled placing an order"];
    }
    
}

-(void) placeOrder:(OrderManager *) anOrderManager
{
    PaymentStack* paymentStack = 
    [[PaymentStack alloc] initWithOrder:[anOrderManager thisOrder] locationState:[[AppData appData] locationState]
                           successBlock:^{
                               //Push the current order on the history list
                               [[[AppData appData] ordersHistory] addObject:[[anOrderManager thisOrder] copy]];
                               if ([[anOrderManager thisOrder] isEffectivelyEqual:[anOrderManager thisOrder]])
                               {
                                   //Allocate a new order
                                   [anOrderManager setOrder:[[Order alloc] init]];
                                   [self viewWillAppear:YES];
                               }
                           }
                        completionBlock:^{

                            [masterView dismissView];
                        }
                      cancellationBlock:^{
                          [masterView dismissView];
                      }];
    [masterView pushView:[[paymentStack navigationController] view]];
}

-(void)displaySpinner
{
    [[[masterView loadingView] progressLabel] setText:@"Contacting Server..."];
    [masterView undissolveProgressIndicator];
}

@end
