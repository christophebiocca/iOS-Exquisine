//
//  PaymentFailureViewController.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PaymentFailureView;

@interface PaymentFailureViewController : UIViewController{
    NSError* failureInfo;
    PaymentFailureView* failureView;
    void (^cancelCallback)();
}

@property(copy, nonatomic)void(^cancelCallback)();

-(void)setError:(NSError*)error;

@end
