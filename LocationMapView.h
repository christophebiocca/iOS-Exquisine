//
//  LocationMapView.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <MapKit/MapKit.h>
@class LocationState;
@class Location;
@class FlexableDictionary;

@interface LocationMapView : MKMapView <MKMapViewDelegate>
{
    LocationState *locationState;
    FlexableDictionary *annotationViewDict;
    MKAnnotationView *lastSelectedView;
}

@property (readonly) LocationState *locationState;

-(id) initWithLocationState:(LocationState *) aLocationState AndFrame:(CGRect)frame;

-(Location *) annotationForAnnotationView:(MKAnnotationView *) view;

@end
