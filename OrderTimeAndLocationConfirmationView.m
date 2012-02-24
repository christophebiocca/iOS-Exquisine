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
@synthesize navBar;
@synthesize orderCompletionDurationPicker;

- (id)initWithLocationState:(LocationState *)locationState
{
    self = [super init];
    if (self) {
        orderCompletionDurationPicker = [[UIPickerView alloc] init];
        
        locationView = [[LocationMapView alloc] initWithLocationState:locationState AndFrame:CGRectMake(0, 73, 320, 229)];
        
        locationPrompt = [[UILabel alloc] init];
        
        navBar = [[UINavigationBar alloc] init];
        
        
        [locationPrompt setText:@"Choose the location and pickup time:"];
        
        [self addSubview:orderCompletionDurationPicker];
        [self addSubview:locationView];
        [self addSubview:locationPrompt];
        [self addSubview:navBar];
        
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

-(void)layoutSubviews
{
    [navBar setFrame:CGRectMake(0, 0, 320, 44)];
    [locationPrompt setFrame:CGRectMake(10, 48, 300, 21)];
    [orderCompletionDurationPicker setFrame:CGRectMake(0, 298,320, 162)];
    
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
