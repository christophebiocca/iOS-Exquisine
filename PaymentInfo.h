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
    NSString* cardholderName;
    NSInteger expirationMonth;
    NSInteger expirationYear;
}

-(void)setCardnumber:(NSString*)number withValidationMessage:(NSString**)retErr;
-(void)setCardholderName:(NSString*)name withValidationMessage:(NSString**)retErr;
-(void)setExpirationMonth:(NSInteger)month withValidationMessage:(NSString**)retErr;
-(void)setExpirationYear:(NSInteger)year withValidationMessage:(NSString**)retErr;

-(NSDictionary*)dictionaryRepresentation;

@end
