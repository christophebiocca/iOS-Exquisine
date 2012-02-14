//
//  PaymentError.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@interface PaymentError : NSObject{
    BOOL isUserError;
    NSString* userMessage;
    NSError* cause;
}

-(id)initWithCause:(NSError*)cause;

@property(readonly)BOOL isUserError;
@property(retain, readonly)NSString* userMessage;
@property(retain, readonly)NSError* cause;

@end
