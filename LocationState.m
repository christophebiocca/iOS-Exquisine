//
//  LocationState.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationState.h"


@implementation LocationState

@synthesize selectedLocation;
@synthesize locations;

-(id)initWithLocations:(NSArray *)someLocations
{
    self = [super init];
    
    if(self)
    {
        locations = someLocations;
        if([someLocations count] > 0 )
            selectedLocation = [someLocations lastObject];
        else
            CLLog(LOG_LEVEL_WARNING, @"A location state object was initialized without any locations");
    }
    return self;
}

-(void)setLocations:(NSArray *)someLocations
{
    if (selectedLocation)
    {
        if ([locations indexOfObject:selectedLocation] < [someLocations count]) {
            selectedLocation = [someLocations objectAtIndex:[locations indexOfObject:selectedLocation]];
        }
    }
    locations = someLocations;
}

@end
