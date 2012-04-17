//
//  PaymentCompletedView.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class PaymentSuccessInfo;
@class Order;

@interface PaymentCompletedView : UIView{
    UILabel* authCode;
    UILabel* messageText;
    UILabel* trnAmount;
    UILabel* trnDate;
    UILabel* pickupTime;
    UILabel* signoff;
    UIButton* postToFacebookButton;
}

@property (retain) UIButton *postToFacebookButton;

-(void)setSuccessInfo:(PaymentSuccessInfo*)info AndOrderInfo:(Order *) theOrder;

@end
