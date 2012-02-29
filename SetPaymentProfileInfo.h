//
//  SetPaymentProfileInfo.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JSONAPICall.h"
@class PaymentInfo;
@class PaymentError;
@class PaymentSuccessInfo;

@interface SetPaymentProfileInfo : JSONAPICall{
    PaymentInfo* info;
}

+(void)setPaymentInfo:(PaymentInfo*)paymentInfo: (void (^)(id))success failure:(void (^)(id, NSError *))failure;

@end
