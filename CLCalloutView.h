//
//  CLCalloutView.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLCalloutView : UIView
{
    NSInteger spikeHeight;
    CGRect endFrame;
}

@property CGRect endFrame;

- (id)initWithFrame:(CGRect)frame AndSpikeHeight: (NSInteger) desiredSpikeHeight;

-(CGPathRef)roundedRectPath:(CGRect)rect radius:(CGFloat)radius;

- (CGFloat)yShadowOffset;
- (CGFloat)relativeParentXPosition;

- (void)animateIn;

- (void)animateOut;

@end
