//
//  PaymentFailureView.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentFailureView : UIView{
    UILabel* error;
}

-(void)setErrorMessage:(NSString*)message;

@end
