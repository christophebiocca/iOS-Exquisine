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
#import "OrderManager.h"
#import "AppData.h"

@implementation MasterViewController

@synthesize masterView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        masterView = [[MasterView alloc] initWithFrame:frame];
        appData = [AppData alloc];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initializationSuccess) name:INITIALIZED_SUCCESS object:appData];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initializationFailure) name:INITIALIZED_FAILURE object:appData];
        appData = [appData init];
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
    LocationTabViewController *locationTabViewController = [[LocationTabViewController alloc] initWithLocationState:[appData locationState]];
    
    [locationTabViewController setTitle:@"Location"];
    
    OrderTabViewController *orderTabViewController = [[OrderTabViewController alloc] initWithOrder:[[appData theOrderManager] thisOrder]];
    
    [orderTabViewController setTitle:@"Order"];
    
    FavoritesViewController *favoritesTabViewController = [[FavoritesViewController alloc] initWithFavoritesListAndMenu:[appData favoriteOrders] :[appData theMenu]];
    
    [favoritesTabViewController setTitle:@"Favorites"];
    
    [[masterView tabController] setViewControllers:[NSArray arrayWithObjects:locationTabViewController,orderTabViewController,favoritesTabViewController,nil]];
    
    [[[masterView tabController] view] setNeedsLayout];
    [[[masterView tabController] view] setNeedsDisplay];
    [masterView dissolveLoadingView];
}

-(void) initializationFailure
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"You must have an internet connection the first time you run this app" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [masterView dissolveProgressIndicator];
    [alert show];
}

@end
