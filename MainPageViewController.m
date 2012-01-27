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

@implementation MainPageViewController

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        [[self navigationItem] setTitle:@"Pita Factory"];
        [[[GetMenu alloc] init] setDelegate:self];
        ordersHistory = [[NSMutableArray alloc] initWithCapacity:0];
        favoriteOrders = [[NSMutableArray alloc] initWithCapacity:0];
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
    
    currentOrder = [[Order alloc] initWithParentMenu:theMenu];
    
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

-(void)apiCall:(APICall *)call completedWithData:(NSDictionary *)data{
    NSLog(@"SUCCESS call: %@ Data:\n%@", call, data);
    theMenu = [[Menu alloc] initFromData:data];
}

-(void)apiCall:(APICall *)call returnedError:(NSError *)error{
    NSLog(@"call %@ errored with %@", call, error);
}

-(void)submitOrderForController:(id)orderViewController
{
    [[orderViewController orderInfo] setStatus:@"Queued"];
    [[orderViewController orderInfo] submit];
    //A bunch of code to interact with the server
    
    //Push the current order on the history list
    [ordersHistory addObject:[orderViewController orderInfo]];
    
    if ([[orderViewController orderInfo] isEqual:currentOrder])
    {
        //Allocate a new order
        currentOrder = [[Order alloc] initWithParentMenu:theMenu];
    }
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
    [favoriteOrders addObject:[[Order alloc] initFromOrder:[orderViewController orderInfo]]];
    //Allocate a new order if needed
    if ([[orderViewController orderInfo] isEqual:currentOrder])
    {
        currentOrder = [[Order alloc] init];
    }
    
    //Move view control to the favorites view.
    
    FavoritesViewController *favoritesViewController = [[FavoritesViewController alloc] initWithFavoritesListAndMenu:favoriteOrders :theMenu];
    
    [favoritesViewController setDelegate:self];
    
    [[self navigationController] setViewControllers:[[NSArray alloc]initWithObjects:self,favoritesViewController, nil] animated:YES]; 
    
}

-(void)deleteFromFavoritesForController:(id)orderViewController
{
    for (Order *anOrder in favoriteOrders) 
    {
        if(anOrder.name == [orderViewController orderInfo].name)
        {
            [[orderViewController orderInfo] setIsFavorite:NO];
            [favoriteOrders removeObject:anOrder];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([[self pendingOrders] count] > 0)
    {
        [mainPageView.pendingOrderButton setTitle:[NSString stringWithFormat:@"Order Status: %@" ,[[[self pendingOrders] lastObject] status]] forState:UIControlStateNormal];
        
        [mainPageView.pendingOrderButton setEnabled:YES];
    }
    else
    {
        [mainPageView.pendingOrderButton setEnabled:NO];
    }
}

@end
