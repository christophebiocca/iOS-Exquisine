//
//  MasterViewControler.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterView.h"
#import "LoadingView.h"
#import "LocationViewController.h"
#import "CustomTabBarController.h"

@implementation MasterView

@synthesize loadingView;
@synthesize tabController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        loadingView = [[LoadingView alloc] initWithFrame:frame];
        
        tabController = [[CustomTabBarController alloc] init];
        tabView = [tabController view];
        
        [self addSubview:tabView];
        [self addSubview:loadingView];
    }
    return self;
}

-(void)dissolveLoadingView
{
    [self fadeOut:loadingView withDuration:2 andWait:0];
    [self performSelector:@selector(sendSubviewToBack:) withObject:loadingView afterDelay:2];
}

-(void)dissolveProgressIndicator
{
    [self fadeOut:[loadingView indicatorView] withDuration:1 andWait:0];
}

-(void)fadeOut:(UIView*)viewToDissolve withDuration:(NSTimeInterval)duration   andWait:(NSTimeInterval)wait
{
    [UIView beginAnimations: @"Fade Out" context:nil];
    
    // wait for time before begin
    [UIView setAnimationDelay:wait];
    
    // druation of animation
    [UIView setAnimationDuration:duration];
    viewToDissolve.alpha = 0.0;
    [UIView commitAnimations];
}

-(void)putUpLoadingView
{
    [loadingView setAlpha:1.0f];
    [self sendSubviewToBack:tabView];
}

-(void)pushView:(UIView *)aView
{
    [self addSubview:aView];
    viewToPush = aView;
}

-(void)dismissView
{
    [UIView beginAnimations: @"Pop off" context:nil];
    
    // wait for time before begin
    [UIView setAnimationDelay:0];
    
    // druation of animation
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.2];
    [viewToPush setFrame:CGRectMake(-320, 0, [viewToPush frame].size.width, [viewToPush frame].size.height)];
    [UIView commitAnimations];
    
    [self performSelector:@selector(cleanupPushedView) withObject:nil afterDelay:0.3];
}

-(void)cleanupPushedView
{
    [viewToPush removeFromSuperview];
}

@end
