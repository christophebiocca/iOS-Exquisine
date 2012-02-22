//
//  LocationViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-21.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LocationView;
@class Location;

@interface LocationViewController : UIViewController
{
    LocationView *locationView;
    NSArray *locations;
}

-(LocationViewController *)initWithLocations:
(NSArray *) theLocations;

@end
