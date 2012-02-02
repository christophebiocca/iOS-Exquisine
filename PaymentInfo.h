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
    NSString* cardholderError;
    NSInteger expirationMonth;
    NSInteger expirationYear;
    NSString* expirationError;
}

@property(retain, readonly)NSString* cardnumberError;
@property(retain, readonly)NSString* cardholderNameError;
@property(retain, readonly)NSString* expirationError;

-(BOOL)anyErrors;

-(void)setCardnumber:(NSString*)number;
-(void)setCardholderName:(NSString*)name;
-(void)setExpirationMonth:(NSInteger)month;
-(void)setExpirationYear:(NSInteger)year;

-(NSDictionary*)dictionaryRepresentation;

@end
