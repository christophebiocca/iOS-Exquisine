//
//  LocationTabView.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-01.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationTabView.h"
#import "LocationMapView.h"
#import "LocationState.h"

@implementation LocationTabView

- (id)initWithLocationState:(LocationState *) locationState AndFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        int locationBarHeight = 47;
        int locationBarOpacityHeight = 44;
        
        int labelWidth = 300;
        int labelHeight = 30;
        
        toolbarText = [[UILabel alloc] initWithFrame:CGRectMake(
                                    (frame.size.width - labelWidth) / 2,
                                    (locationBarOpacityHeight - labelHeight) / 2, 
                                    labelWidth, 
                                    labelHeight)];
        [toolbarText setFont:[UIFont fontWithName:@"Optima-ExtraBlack" size:22]];
        [toolbarText setTextColor:[UIColor whiteColor]];
        [toolbarText setBackgroundColor:[UIColor clearColor]];
        [toolbarText setTextAlignment:UITextAlignmentCenter];
        
        locationMapView = [[LocationMapView alloc] initWithLocationState:locationState AndFrame:CGRectMake(
                                    frame.origin.x, 
                                    frame.origin.y + locationBarOpacityHeight, 
                                    frame.size.width, 
                                    frame.size.height - locationBarOpacityHeight)];
        
        whiteBar = [[UIView alloc] initWithFrame:CGRectMake(
                                    frame.origin.x, 
                                    frame.origin.y + locationBarOpacityHeight, 
                                    frame.size.width, 
                                    34)];
        [whiteBar setBackgroundColor:[UIColor whiteColor]];
        [whiteBar setAlpha:0.8f];
        
        whiteBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                    ([whiteBar frame].size.width - labelWidth)/2 + [whiteBar frame].origin.x, 
                                    ([whiteBar frame].size.height - labelHeight)/2 + [whiteBar frame].origin.y, 
                                    labelWidth, 
                                    labelHeight)];
        
        
        [whiteBarLabel setBackgroundColor:[UIColor clearColor]];
        [whiteBarLabel setTextAlignment:UITextAlignmentCenter];
        [whiteBarLabel setAdjustsFontSizeToFitWidth:YES];
        [whiteBarLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0f]];
        [whiteBarLabel setTextColor:[UIColor colorWithRed:0.5f green:0.03f blue:0.03f alpha:1.0f]];
        
        locationToolBarImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BlankTopbarWithShadow.png"]];
        
        [locationToolBarImage setFrame:CGRectMake(
                                    frame.origin.x, 
                                    frame.origin.y, 
                                    frame.size.width, 
                                    locationBarHeight)];
        
        
        [whiteBarLabel setText:@"Tap a location to order from"];
        [toolbarText setText:@"Locations"];
        
        [self addSubview:locationMapView];
        [self addSubview:whiteBar];
        [self addSubview:whiteBarLabel];
        [self addSubview:locationToolBarImage];
        [self addSubview:toolbarText];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
