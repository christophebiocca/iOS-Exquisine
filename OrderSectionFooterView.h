//
//  OrderSectionFooterView.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *PLACE_BUTTON_PRESSED;

@interface OrderSectionFooterView : UIView
{
    UIImageView *footerImage;
    UIButton *placeLabel;
    
}

@property (retain) UIButton *placeLabel;

@end
