//
//  PaymentProfileInfo.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentProfileInfo.h"

@implementation PaymentProfileInfo

@synthesize last4Digits;

-(id)initWithData:(NSDictionary *)data{
    if(self = [super init]){
        last4Digits = [data objectForKey:@"last_4_digits"];
    }
    return self;
}

@end
