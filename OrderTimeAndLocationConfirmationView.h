//
//  OrderTimeAndLocationConfirmationView.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-22.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@class LocationMapView;
@class LocationViewController;
@class LocationState;
@class PickerViewLayover;

@interface OrderTimeAndLocationConfirmationView : UIView
{
    UIPickerView *orderCompletionDurationPicker;
    LocationMapView *locationView;
    UILabel *locationPrompt;
    UINavigationBar *navBar;
    
}

- (id)initWithLocationState:(LocationState *)locationState;

@property (readonly) LocationMapView *locationView;
@property (retain) UINavigationBar *navBar;
@property (retain) UIPickerView *orderCompletionDurationPicker;

@end
