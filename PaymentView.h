//
//  PaymentView.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PaymentInfo;

@interface PaymentView : UIView<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>{
    PaymentInfo* info;
    UIToolbar* topBar;
    UIBarButtonItem* done;
    UIBarButtonItem* cancel;
    UITextField* cardholderNameField;
    UITextField* cardnumberField;
    UILabel* expirationLabel;
    UIPickerView* expiration;
}

@property(retain, readonly)PaymentInfo* paymentInfo;
@property(retain, readonly)UIBarButtonItem* done;
@property(retain, readonly)UIBarButtonItem* cancel;

@end
