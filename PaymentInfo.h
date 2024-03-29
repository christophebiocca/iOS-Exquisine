//
//  PaymentInfo.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaymentInfo : NSObject{
    @private
    NSString* cardnumber;
    NSString* cardnumberError;
    NSString* cardholderName;
    NSString* cardholderNameError;
    NSInteger expirationMonth;
    NSInteger expirationYear;
    NSString* expirationError;
    
    BOOL remember;
}

@property(retain, readonly)NSString* cardnumberError;
@property(retain, readonly)NSString* cardholderNameError;
@property(retain, readonly)NSString* expirationError;
@property(assign, nonatomic)BOOL remember;

-(BOOL)anyErrors;

-(void)setCardnumber:(NSString*)number;
-(void)setCardholderName:(NSString*)name;
-(void)setExpirationMonth:(NSString*)month;
-(void)setExpirationYear:(NSString*)year;

-(NSDictionary*)dictionaryRepresentation;

@end
