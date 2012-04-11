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

@interface PaymentView : UIView{

    UILabel* serverErrorMessageLabel;
    
    UILabel* cardholderNameLabel;
    UILabel* cardholderNameErrorLabel;
    UITextField* cardholderNameField;
    
    UILabel* cardnumberLabel;
    UILabel* cardnumberErrorLabel;
    UITextField* cardnumberField;
    
    UILabel* rememberLabel;
    UISwitch* remember;

    UILabel* expirationLabel;
    UILabel* expirationErrorLabel;
    UITextField* expirationMonth;
    UITextField* expirationYear;
}

@property (retain) UITextField *cardholderNameField;
@property (retain) UILabel *cardholderNameErrorLabel;
@property (retain) UITextField *cardnumberField;
@property (retain) UILabel *cardnumberErrorLabel;
@property (retain) UISwitch *remember;
@property (retain) UITextField *expirationMonth;
@property (retain) UITextField *expirationYear;
@property (retain) UILabel *expirationErrorLabel;

-(void)setErrorMessage:(NSString*)message onErrorLabel:(UILabel*)label;
-(void)setErrorMessage:(NSString*)message;

@end
