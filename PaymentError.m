//
//  PaymentError.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentError.h"
#import "PlaceOrder.h"

@implementation PaymentError

@synthesize isUserError, userMessage, cause;

-(id)initWithCause:(NSError*)theCause{
    if(self = [super init]){
        cause = theCause;
        isUserError = NO;
        if([cause domain] == JSON_API_ERROR){
            isUserError = YES;
            userMessage = @"Your credit card info is invalid.";
        }
    }
    return self;
}

@end
