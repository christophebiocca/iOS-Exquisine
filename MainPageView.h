//
//  MainPage.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainPageView : UIView{
    
    UIButton *createOrderButton;
    UIButton *favoriteOrderButton;
    UIButton *accountInfoButton;
    UIButton *pendingOrderButton;
    UILabel *greetingLabel;
    UILabel *orderStatus;
}

@property (retain) UIButton *createOrderButton;  	
@property (retain) UIButton *pendingOrderButton;
@property (retain) UIButton *favoriteOrderButton;
@property (retain) UIButton *accountInfoButton;
@property (retain) UILabel *greetingLabel;
@property (retain) UILabel *orderStatus;
@property (retain) UIImage *logo;
@property (retain) UIImageView *logoView;

@end