//
//  PaymentSuccessInfo.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@interface PaymentSuccessInfo : NSObject
{
    NSString* authCode;
    NSString* messageText;
    NSString* trnAmount;
    NSString* trnDate;
    
}

@property (retain, readonly) NSString *authCode;
@property (retain, readonly) NSString *messageText;
@property (retain, readonly) NSString *trnAmount;
@property (retain, readonly) NSString *trnDate;

-(id)initWithData:(NSDictionary*)data;

@end
