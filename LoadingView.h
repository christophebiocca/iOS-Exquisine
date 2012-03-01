//
//  LoadingView.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView
{
    UIImageView *splashImage;
    UIActivityIndicatorView *indicatorView;
    UILabel *progressLabel;
}

@property (retain) UIActivityIndicatorView *indicatorView;

@end
