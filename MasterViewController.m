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
#import "FavoritesViewController.h"
#import "Order.h"
#import "OrderManager.h"
#import "PaymentStack.h"
#import "AppData.h"
#import "CustomTabBarController.h"

@implementation MasterViewController

@synthesize masterView;
@synthesize appData;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        masterView = [[MasterView alloc] initWithFrame:frame];
        appData = [AppData alloc];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initializationSuccess) name:INITIALIZED_SUCCESS object:appData];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initializationFailure) name:INITIALIZED_FAILURE object:appData];
        appData = [appData init];
        [[[masterView loadingView] progressLabel] setText:@"Contacting Server..."];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    [self setView:masterView];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) initializationSuccess
{
    [[[masterView loadingView] progressLabel] setText:@"Initialization Complete"];
    LocationTabViewController *locationTabViewController = [[LocationTabViewController alloc] initWithLocationState:[appData locationState]];
    
    [locationTabViewController setTitle:@"Location"];
    
    OrderTabViewController *orderTabViewController = [[OrderTabViewController alloc] initWithOrderManager:[appData theOrderManager]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(placeOrder:) name:ORDER_PLACEMENT_REQUESTED object:[appData theOrderManager]];
    
    UINavigationController *orderTabNavigationController = [[UINavigationController alloc] initWithRootViewController:orderTabViewController];
    [orderTabNavigationController setHidesBottomBarWhenPushed:YES];
    
    [orderTabNavigationController setTitle:@"Order"];
    
    FavoritesViewController *favoritesTabViewController = [[FavoritesViewController alloc] initWithFavoritesListAndMenu:[appData favoriteOrders] :[appData theMenu]];
    
    [favoritesTabViewController setTitle:@"Favorites"];
    
    [[masterView tabController] setViewControllers:[NSArray arrayWithObjects:locationTabViewController,orderTabNavigationController,favoritesTabViewController,nil]];
    
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
    [appData initializeFromServer];
    [masterView performSelector:@selector(dissolveLoadingView) withObject:nil afterDelay:2];
}

-(void) placeOrder:(NSNotification *) aNotification
{
    if ([[aNotification object] isKindOfClass:[OrderManager class]]) {
        
        PaymentStack* paymentStack = 
        [[PaymentStack alloc] initWithOrder:[[aNotification object] thisOrder] locationState:[appData locationState]
                               successBlock:^{
                                   //Push the current order on the history list
                                   [[appData ordersHistory] addObject:[[aNotification object] thisOrder]];
                                   if ([[[aNotification object] thisOrder] isEffectivelyEqual:[[appData theOrderManager] thisOrder]])
                                   {
                                       //Allocate a new order
                                       [[appData theOrderManager] setOrder:[[Order alloc] init]];
                                   }
                               }
                            completionBlock:^{
                                [self dismissModalViewControllerAnimated:YES];
                            } 
                          cancellationBlock:^{
                              [self dismissModalViewControllerAnimated:YES];
                          }];
        modalController = [paymentStack navigationController];
        [self presentModalViewController:modalController animated:YES];
    }
    else {
        CLLog(LOG_LEVEL_ERROR, @"An object not of type OrderManager was sent to MasterViewController's placeOrder:  omgwtfhax. That is all.");
    }
}

@end
