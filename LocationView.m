//
//  LocationView.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-21.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationView.h"

@implementation LocationView

@synthesize locationMap;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        locationMap = [[MKMapView alloc] init];
        [self addSubview:locationMap];
        [self layoutSubviews];
    }
    return self;
}

-(void)layoutSubviews
{
    [locationMap setFrame:CGRectMake(0, 0, 320, 416)];
}

@end
