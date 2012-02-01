//
//  PaymentViewDelegate.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-31.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@protocol PaymentViewDelegate<NSObject>

-(void)paymentCancelled;
-(void)paymentDone;

@end