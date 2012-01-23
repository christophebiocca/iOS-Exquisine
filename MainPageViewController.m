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

@implementation MainPageViewController

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        [[self navigationItem] setTitle:@"Pita Factory"];
        [[[GetMenu alloc] init] setDelegate:self];
        ordersHistory = [[NSMutableArray alloc] initWithCapacity:0];
        favoriteOrders = [[NSMutableArray alloc] initWithCapacity:0];
        currentOrder = [[Order alloc] init];
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
    
    OrderViewController *orderView = [[OrderViewController alloc] initializeWithMenuAndOrder:theMenu:currentOrder];
    
    [orderView setDelegate:self];
    
    [[self navigationController] pushViewController:orderView animated:YES];
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

-(void)apiCall:(APICall *)call completedWithData:(NSData *)data{
    NSLog(@"SUCCESS call: %@ Data:\n%@", call, data);
    theMenu = [[Menu alloc] initFromData:data];
}

-(void)apiCall:(APICall *)call returnedError:(NSError *)error{
    NSLog(@"call %@ errored with %@", call, error);
}

-(void)submitOrderForController:(id)orderViewController
{
    [[orderViewController orderInfo] setStatus:@"Queued"];
    //A bunch of code to interact with the server
    
    //Push the current order on the history list
    [ordersHistory addObject:[orderViewController orderInfo]];
    
    if ([[orderViewController orderInfo] isEqual:currentOrder])
    {
        //Allocate a new order
        currentOrder = [[Order alloc] init];
    }
}
-(void)addToFavoritesForController:(id)orderViewController
{
    //This check really isn't sufficient. We should be checking for name collisions.
    //I'll do it eventually.
    if(![favoriteOrders containsObject:[orderViewController orderInfo]])
    {
        [[orderViewController orderInfo] setIsFavorite:YES];
        //Push the current order on the favorites list
        [favoriteOrders addObject:[[orderViewController orderInfo] copy]];
        //Allocate a new order if needed
        if ([[orderViewController orderInfo] isEqual:currentOrder])
        {
            currentOrder = [[Order alloc] init];
        }
    }
    else
    {
        UIAlertView *tsktsk = [[UIAlertView alloc] initWithTitle:@"Error" message:@"That order is already in the favorites list!" delegate:self cancelButtonTitle:@"OK, my bad" otherButtonTitles:nil];
        
        [tsktsk setTag:3];
        
        [tsktsk show];
    }
}

@end
