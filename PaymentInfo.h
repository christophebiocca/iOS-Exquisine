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
    NSDate* expiration;
}

-(void)setCardnumber:(NSString*)number;
-(void)setCardholderName:(NSString*)name;
-(void)setExpiration:(NSDate*)expiration;

-(NSDictionary*)dictionaryRepresentation;

@end
