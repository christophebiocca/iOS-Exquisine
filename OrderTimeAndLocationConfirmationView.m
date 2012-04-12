//
//  OrderTimeAndLocationConfirmationView.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-22.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderTimeAndLocationConfirmationView.h"
#import "LocationMapView.h"
#import "LocationViewController.h"


@implementation OrderTimeAndLocationConfirmationView

@synthesize locationView;
@synthesize orderCompletionDurationPicker;

- (id)initWithLocationState:(LocationState *)locationState
{
    self = [super init];
    if (self) {
        orderCompletionDurationPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 254,320, 162)];
        
        [orderCompletionDurationPicker setShowsSelectionIndicator:YES];
        
        locationView = [[LocationMapView alloc] initWithLocationState:locationState AndFrame:CGRectMake(0, 29, 320, 229)];
        
        locationPrompt = [[UILabel alloc] init];
        
        [locationPrompt setFont:[Utilities fravicHeadingFont]];
        
        [locationPrompt setText:@"Choose the location and pickup time:"];
        
        [self addSubview:orderCompletionDurationPicker];
        [self addSubview:locationView];
        [self addSubview:locationPrompt];
        
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

-(void)layoutSubviews
{
    [locationPrompt setFrame:CGRectMake(10, 4, 300, 21)];

}

@end
