//
//  MainPage.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainPage.h"
#import "MainPageView.h"
#import "OrderPage.h"
#import "CellData.h"
#import "TableData.h"

@implementation MainPage

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        [[self navigationItem] setTitle:@"Pita Factory"];
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
    
    //This is the original code, I'm switching it out!
    
    OrderPage *orderPage = [[OrderPage alloc] init];
    
    [[self navigationController] pushViewController:orderPage animated:YES];
     
    
    //This is for testing purposes only.
    //[self testFunction];
}

-(void)testFunction{
    TableData *testTable = [[TableData alloc] initWithNavigationController:[self navigationController]];
    testTable.tableName = @"Testing";
    
    for (int i = 0; i < 20; i++) {
        CellData *newcell = [[CellData alloc] init];
        newcell.cellTitle = [NSString stringWithFormat:@"Cell %i",i];
        newcell.cellDesc = [NSString stringWithFormat:@"This is cell number %i",i];
        [testTable.cellDataList addObject:newcell];
    }
    
    [[self navigationController] pushViewController:testTable animated:true];
    
}

@end
