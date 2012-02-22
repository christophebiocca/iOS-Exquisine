//
//  LocationView.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-21.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LocationView : UIView
{
    MKMapView *locationMap;
}

@property (retain) MKMapView *locationMap;

@end
