//
//  PaymentSettingsViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PaymentSettingsView;
@interface PaymentSettingsViewController : UIViewController <UIAlertViewDelegate>
{
    PaymentSettingsView *paymentSettingsView;
}

- (void) refreshCreditCardInfo;

@end
