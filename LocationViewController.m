//
//  LocationViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-21.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationViewController.h"
#import "LocationView.h"
#import "Location.h"

#define DEFAULT_VIEW_SCALE 40000

@implementation LocationViewController

-(LocationViewController *)initWithLocations:
(NSArray *) theLocations
{
    self = [super init];
 
    locations = theLocations;
    locationView = [[LocationView alloc] init];
    
    [[self navigationItem] setTitle:@"Choose Location"];
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated 
{
    CLLocationCoordinate2D currentLocation;
    currentLocation.latitude = 43.47256;
    currentLocation.longitude = -80.53830;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMake(currentLocation, MKCoordinateSpanMake(0.008f, 0.008f));
    // 3
    MKCoordinateRegion adjustedRegion = [[locationView locationMap] regionThatFits:viewRegion];                
    // 4
    [[locationView locationMap] setRegion:adjustedRegion animated:YES];
    
    for (Location *eachLocation in locations) {
        [[locationView locationMap] addAnnotation:eachLocation];
    }
    
}

- (void) loadView
{
    [self setView:locationView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
