//
//  LocationViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-21.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mapkit/Mapkit.h>
@class LocationMapView;
@class LocationState;

@interface LocationViewController : UIViewController
{
    LocationMapView *locationMapView;
    LocationState *locationState;
}

@property (readonly) LocationMapView *locationMapView;

-(LocationViewController *)initWithLocationState:
(LocationState *) aLocationState;

@end
