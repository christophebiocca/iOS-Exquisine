//
//  LocationState.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Location;

@interface LocationState : NSObject
{
    Location *selectedLocation;
    NSArray *locations;
}

-initWithLocations:(NSArray *) someLocations;

@property (retain) Location *selectedLocation;
@property (retain) NSArray *locations;

@end
