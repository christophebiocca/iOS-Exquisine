//
//  PaymentConfirmationView.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentConfirmationView : UIView{
    UIToolbar* bar;
    
    UILabel* notificationMessage;
    
    UIBarButtonItem* confirm;
    UIBarButtonItem* cancel;
    UIButton* change;
}

-(id)initWithCCDigits:(NSString*)ccDigits;

@property(retain, readonly)UIBarButtonItem* confirm;
@property(retain, readonly)UIBarButtonItem* cancel;
@property(retain, readonly)UIButton* change;

-(void)setCCDigits:(NSString*)ccDigits;

@end
