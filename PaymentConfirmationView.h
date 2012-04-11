//
//  PaymentConfirmationView.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentConfirmationView : UIView{
    UILabel* notificationMessage;
    
    UIButton* accept;
    UIButton* change;
}

-(id)initWithCCDigits:(NSString*)ccDigits;

@property(retain, readonly)UIButton* accept;
@property(retain, readonly)UIButton* change;

-(void)setCCDigits:(NSString*)ccDigits;

@end
