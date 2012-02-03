//
//  PaymentCompletedView.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class PaymentSuccessInfo;

@interface PaymentCompletedView : UIView{
    UIBarButtonItem* done;
}

-(void)setSuccessInfo:(PaymentSuccessInfo*)info;

@property(retain, readonly)UIBarButtonItem* done;

@end
