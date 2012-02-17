//
//  GetPaymentProfileInfo.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GetPaymentProfileInfo.h"
#import "PaymentProfileInfo.h"

@implementation GetPaymentProfileInfo

@synthesize info;

+(void)fetchInfo:(void (^)(id))success failure:(void (^)(id, NSError *))failure{
    [self sendGETRequestForLocation:@"customer/paymentinfo/"
                            success:success
                            failure:failure];
}

-(void)postCompletionHook{
    [super postCompletionHook];
    if(![self error]){
        info = [[PaymentProfileInfo alloc] initWithData:[self jsonData]];
    }
}

@end
