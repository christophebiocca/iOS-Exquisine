//
//  PaymentFailureView.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentFailureView : UIView{
    UIToolbar* bar;
    UIBarButtonItem* cancel;
    UILabel* error;
}

@property(retain, readonly)UIBarButtonItem* cancel;

-(void)setErrorMessage:(NSString*)message;

@end
