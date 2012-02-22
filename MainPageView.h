//
//  MainPage.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IndicatorView;

@interface MainPageView : UIView{
    
    UIButton *createOrderButton;
    UIButton *favoriteOrderButton;
    UIButton *locationButton;
    UIButton *pendingOrderButton;
    UILabel *orderStatus;
    UILabel *storeHours;
    UILabel *storeLocationLabel;
    IndicatorView *openIndicator;
}

@property (retain) UIButton *createOrderButton;  	
@property (retain) UIButton *pendingOrderButton;
@property (retain) UIButton *favoriteOrderButton;
@property (retain) UIButton *locationButton;
@property (retain) UILabel *orderStatus;
@property (retain) UILabel *storeLocationLabel;
@property (retain) UIImage *logo;
@property (retain) UIImageView *logoView;
@property (retain) IndicatorView *openIndicator;
@property (retain) UILabel *storeHours;

@end