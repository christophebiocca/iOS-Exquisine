//
//  MasterViewControler.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoadingView;
@class CustomTabBarController;

@interface MasterView : UIView
{
    LoadingView *loadingView;
    CustomTabBarController *tabController;
    UIView *viewToPush;
    UIView *tabView;
}

@property (retain) LoadingView *loadingView;
@property (retain) CustomTabBarController *tabController;

-(void)dissolveLoadingView;

-(void)dissolveProgressIndicator;

-(void)undissolveProgressIndicator;

-(void)fadeOut:(UIView*)viewToDissolve withDuration:(NSTimeInterval)duration   andWait:(NSTimeInterval)wait;

-(void)fadeIn:(UIView*)viewToDissolve withDuration:(NSTimeInterval)duration   andWait:(NSTimeInterval)wait;

-(void)putUpLoadingView;

-(void)pushView:(UIView *)aView;

-(void)dismissView;

@end
