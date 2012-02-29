//
//  SetPaymentProfileInfo.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SetPaymentProfileInfo.h"
#import "PaymentInfo.h"
#import "PaymentSuccessInfo.h"
#import "PaymentError.h"

@implementation SetPaymentProfileInfo

+(void)setPaymentInfo:(PaymentInfo*)paymentInfo: (void (^)(id))success failure:(void (^)(id, NSError *))failure
{
    
    [self sendPOSTRequestForLocation:@"customer/changepaymentprofile/" 
                        withJSONData:[paymentInfo dictionaryRepresentation] 
                             success: success
                             failure:failure];
}
@end
