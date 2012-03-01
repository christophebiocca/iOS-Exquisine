//
//  LocationTabView.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-01.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LocationMapView;
@class LocationState;

@interface LocationTabView : UIView
{
    LocationMapView *locationMapView;
    UIImageView *locationToolBarImage;
    UIView *whiteBar;
    UILabel *whiteBarLabel;
}

- (id)initWithLocationState:(LocationState *) locationState AndFrame:(CGRect)frame;

@end
