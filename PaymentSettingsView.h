//
//  PaymentSettingsView.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentSettingsView : UIView
{
    UILabel *creditCardLabel;
    UIButton *changeInfoButton;
    UIButton *deleteInfoButton;
}

@property (retain) UILabel *creditCardLabel;
@property (retain) UIButton *changeInfoButton;
@property (retain) UIButton *deleteInfoButton;

@end
