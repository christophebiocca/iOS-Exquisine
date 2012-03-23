//
//  LoadingView.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

@synthesize progressLabel;
@synthesize indicatorView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        splashImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"splashScreen.jpg"]];
        indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [indicatorView startAnimating];
        progressLabel = [[UILabel alloc] init];
        [progressLabel setBackgroundColor:[UIColor clearColor]];
        [progressLabel setTextAlignment:UITextAlignmentCenter];
        [progressLabel setAdjustsFontSizeToFitWidth:YES];
        [progressLabel setTextColor:[UIColor blackColor]];
        [progressLabel setText:@"Initializing..."];
        
        [self addSubview:splashImage];
        [self addSubview:indicatorView];
        [self addSubview:progressLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    int labelWidth = 200;
    int labelDistanceFromIndicator = 10;
    
    int indicatorWidth = 37;
    double heightCoeficient = 0.8;
    double widthCoeficient = 0.5;
    
    [splashImage setFrame:[self frame]];
    
    [indicatorView setFrame:CGRectMake(
                ([self frame].size.width * widthCoeficient)  - (indicatorWidth / 2), 
                ([self frame].size.height * heightCoeficient) - (indicatorWidth / 2), 
                indicatorWidth, 
                indicatorWidth)];
    
    [progressLabel setFrame:CGRectMake(
                [indicatorView frame].origin.x + (indicatorWidth / 2) - (labelWidth / 2),
                [indicatorView frame].origin.y + indicatorWidth + labelDistanceFromIndicator, 
                labelWidth, 
                21)];
}

-(void)setAlpha:(CGFloat)alpha
{
    [super setAlpha:alpha];
    [splashImage setAlpha:alpha];
    [indicatorView setAlpha:alpha];
    [progressLabel setAlpha:alpha];
}

@end
