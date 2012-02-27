//
//  CLPinAnnotationView.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <MapKit/MapKit.h>
@class CLCalloutView;

@interface CLPinAnnotationView : MKPinAnnotationView
{
    CLCalloutView *calloutView;
    UILabel *titleLabel;
    UILabel *subtitleLabel;
}

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *subtitleLabel;

-(void)setSelected:(BOOL)selected animated:(BOOL)animated;


@end
