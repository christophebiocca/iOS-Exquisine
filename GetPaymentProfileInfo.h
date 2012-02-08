//
//  GetPaymentProfileInfo.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JSONAPICall.h"

@class PaymentProfileInfo;

@interface GetPaymentProfileInfo : JSONAPICall{
    PaymentProfileInfo* info;
}

+(void)fetchInfo:(void(^)(id))success failure:(void(^)(id,NSError*))failure;

@property(retain, readonly)PaymentProfileInfo* info;

@end
