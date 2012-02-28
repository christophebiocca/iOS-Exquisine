//
//  PaymentSettingsViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentSettingsViewController.h"
#import "PaymentSettingsView.h"
#import "PaymentInfoViewController.h"
#import "PaymentStack.h"
#import "GetPaymentProfileInfo.h"
#import "PaymentProfileInfo.h"
#import "DeletePaymentInfo.h"

@implementation PaymentSettingsViewController

- (id)init {
    self = [super init];
    if (self) {
        paymentSettingsView = [[PaymentSettingsView alloc] init];
        
        [[paymentSettingsView changeInfoButton] addTarget:self action:@selector(changePaymentInfo) forControlEvents:UIControlEventTouchUpInside];
        
        [[paymentSettingsView deleteInfoButton] addTarget:self action:@selector(deletePaymentInfo) forControlEvents:UIControlEventTouchUpInside];
        
        [self refreshCreditCardInfo];
        
    }
    return self;
}

-(void)refreshCreditCardInfo
{
    [GetPaymentProfileInfo fetchInfo:^(GetPaymentProfileInfo* request){
        CLLog(LOG_LEVEL_INFO, [NSString stringWithFormat:@"Success %@", self]);
        [[paymentSettingsView creditCardLabel] setText:[NSString stringWithFormat:@"Your credit card's last four digits are: %@",[[request info] last4Digits]]];
    } failure:^(GetPaymentProfileInfo* info, NSError* error){
        if([[error domain] isEqualToString:JSON_API_ERROR] && 
           [[[error userInfo] objectForKey:@"class"] isEqualToString:@"NoPaymentInfoError"]){
            [[paymentSettingsView creditCardLabel] setText:@"You have not yet registered a credit card"];
        } else {
            [[paymentSettingsView creditCardLabel] setText:@"Unable to fetch payment information"];
            CLLog(LOG_LEVEL_ERROR, @"Payment info request failed from payment settings page.");
        }
    }];
}

- (void) changePaymentInfo
{
    PaymentInfoViewController *controller = [[PaymentInfoViewController alloc] init];
    
    [controller setCompletionBlock:^(PaymentInfo* info){
        [[self navigationController] popViewControllerAnimated:YES];
    }];
    [controller setCancelledBlock:^{
        [[self navigationController] popViewControllerAnimated:YES];
    }];
    
    [[self navigationController] pushViewController:controller animated:YES];
}

- (void) deletePaymentInfo
{
    [DeletePaymentInfo deletePaymentInfo:^(APICall *theAPICall)
    {
        [self refreshCreditCardInfo];
    }
    failure:^(APICall *theAPICall, NSError *anError) 
    {
        UIAlertView *oops = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Your credit card info could not be deleted because the server cannot be accessed at the moment. Please try again later." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        
        [oops show];
    }];
}

- (void) loadView
{
    [self setView:paymentSettingsView];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self refreshCreditCardInfo];
}

@end
