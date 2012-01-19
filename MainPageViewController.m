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
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) loadView
{
    mainPageView = [[MainPageView alloc] init];
    
    [mainPageView.createOrderButton addTarget:self action:@selector(createOrderPressed) forControlEvents:UIControlEventTouchUpInside];     
    
    [self setView:mainPageView];
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

- (void)createOrderPressed{
    
    if(!theMenu)
    {
        NSLog(@"The menu had not been fetched upon clicking new order");
    }
    
    Order *newOrder = [[Order alloc] init];
    
    OrderViewController *orderView = [[OrderViewController alloc] initializeWithMenuAndOrder:theMenu:newOrder];
    
    [[self navigationController] pushViewController:orderView animated:YES];
}

-(NSMutableArray *)pendingOrders
{
    NSMutableArray *pendingOrderList = [[NSMutableArray alloc] initWithCapacity:0];
    for (Order *anOrder in ordersHistory) {
        [pendingOrderList addObject:anOrder];
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

@end
