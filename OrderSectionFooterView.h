//
//  OrderSectionFooterView.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *EDIT_BUTTON_PRESSED;
extern NSString *PLACE_BUTTON_PRESSED;

@interface OrderSectionFooterView : UIView
{
    UIImageView *footerImage;
    UIButton *placeLabel;
    UIButton *editLabel;
    
}

@property (retain) UIButton *placeLabel;
@property (retain) UIButton *editLabel;

@end
