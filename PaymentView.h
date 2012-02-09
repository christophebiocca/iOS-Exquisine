//
//  PaymentView.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PaymentInfo;
@protocol PaymentViewDelegate;

@interface PaymentView : UIView<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>{
    id<PaymentViewDelegate>delegate;
    
    PaymentInfo* info;
    UIToolbar* topBar;
    UIToolbar* botBar;
    UIBarButtonItem* done;
    UIBarButtonItem* cancel;
    
    UILabel* serverErrorMessageLabel;
    
    UILabel* cardholderNameLabel;
    UILabel* cardholderNameErrorLabel;
    UITextField* cardholderNameField;
    
    UILabel* cardnumberLabel;
    UILabel* cardnumberErrorLabel;
    UITextField* cardnumberField;
    
    UILabel* expirationLabel;
    UILabel* expirationErrorLabel;
    UIPickerView* expiration;
}

@property(retain, readonly)PaymentInfo* paymentInfo;
@property(retain, nonatomic)id<PaymentViewDelegate> delegate;

-(void)setErrorMessage:(NSString*)message;

@end
