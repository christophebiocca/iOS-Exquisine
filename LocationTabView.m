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
        [whiteBarLabel setText:@"Tap a location to order from"];
        [whiteBarLabel setTextAlignment:UITextAlignmentCenter];
        [whiteBarLabel setAdjustsFontSizeToFitWidth:YES];
        [whiteBarLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0f]];
        [whiteBarLabel setTextColor:[UIColor colorWithRed:0.5f green:0.03f blue:0.03f alpha:1.0f]];
        
        locationToolBarImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LocationBarImageShadow.png"]];
        
        [locationToolBarImage setFrame:CGRectMake(
                                    frame.origin.x, 
                                    frame.origin.y, 
                                    frame.size.width, 
                                    locationBarHeight)];
        
        [self addSubview:locationMapView];
        [self addSubview:whiteBar];
        [self addSubview:whiteBarLabel];
        [self addSubview:locationToolBarImage];
        
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
