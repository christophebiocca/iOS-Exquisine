//
//  LocationViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-21.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationViewController.h"
#import "LocationMapView.h"
#import "LocationState.h"
#import "Location.h"

@implementation LocationViewController

@synthesize locationMapView;

-(LocationViewController *)initWithLocationState:
(LocationState *) aLocationState
{
    self = [super init];
 
    locationState = aLocationState;
    locationMapView = [[LocationMapView alloc] initWithLocationState:aLocationState AndFrame:CGRectMake(0, 44, 320, 416)];
    
    [[self navigationItem] setTitle:@"Set Location"];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
    
    [[self navigationItem] setRightBarButtonItem:doneButton];
    
    return self;
}

-(void) doneButtonPressed
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    
}

- (void) loadView
{
    [super loadView];
    [self setView:locationMapView];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
