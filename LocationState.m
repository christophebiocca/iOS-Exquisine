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

- (LocationState *)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        selectedLocation = [decoder decodeObjectForKey:@"selectedLocation"];
        locations = [decoder decodeObjectForKey:@"locations"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:selectedLocation forKey:@"selectedLocation"];
    [encoder encodeObject:locations forKey:@"locations"];
}


@end
