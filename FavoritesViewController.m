//
//  FavoritesViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavoritesViewController.h"
#import "FavoritesView.h"
#import "FavoritesRenderer.h"
#import "OrderViewController.h"
#import "Menu.h"

@implementation FavoritesViewController

@synthesize delegate;

-(FavoritesViewController *)initWithFavoritesListAndMenu:(NSMutableArray *)favList:(Menu *)aMenu
{
    self = [super init];
    
    currentMenu = aMenu;
    
    favoritesList = favList;
    favoritesRenderer = [[FavoritesRenderer alloc] initWithOrderListAndMenu:favoritesList :currentMenu];
    favoritesView = [[FavoritesView alloc] init];
    
    [[favoritesView orderTable] setDelegate:self];
    [[favoritesView orderTable] setDataSource:favoritesRenderer];
    
    [[self navigationItem] setTitle:@"Favorites"];
    
    return self;
}

//Delegate functions
//***********************************************************

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    if ([indexPath row] < [favoritesList count]) {
        OrderViewController *newOrderViewController = [[OrderViewController alloc] initializeWithMenuAndOrder:currentMenu :[favoritesList objectAtIndex:[indexPath row]]];
        
        [newOrderViewController setDelegate:self];
        
        [[self navigationController] pushViewController:newOrderViewController animated:YES];
        
        //Make and push the order view controller
    }
    
}

-(void)tableView:(UITableView *) tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *) indexPath
{
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
}

//Just pass up the delegation.
-(void)addToFavoritesForController:(id)orderViewController
{
    [delegate addToFavoritesForController:orderViewController];
}

-(void)deleteFromFavoritesForController:(id)orderViewController
{
    [delegate deleteFromFavoritesForController:orderViewController];
}

-(void) submitOrderForController:(OrderViewController *)orderViewController
{
    [delegate submitOrderForController:orderViewController];
}

//View related functions
//***********************************************************

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) loadView
{
    [self setView:favoritesView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[favoritesView orderTable] reloadData];
    [favoritesView reloadInputViews];
}

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
@end
