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

@synthesize userMessage, cause;

-(id)initWithCause:(NSError*)theCause{
    if(self = [super init]){
        cause = theCause;
        if([cause domain] == SERVER_HTTP_ERROR_DOMAIN){
            userMessage = @"Our servers appear to be unresponsive at the moment.";
        } else if([cause domain] == JSON_API_ERROR){
            userMessage = @"Your credit card info is invalid.";
        }
    }
    return self;
}

@end
