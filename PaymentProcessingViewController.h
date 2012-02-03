//
//  PaymentProcessingViewController.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class PaymentSuccessInfo;
@class PaymentError;

@interface PaymentProcessingViewController : UIViewController{
    void (^success)(PaymentSuccessInfo*);
    void (^failure)(PaymentError*);
}

-(id)init;

@end
