//
//  DeletePaymentInfo.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DeletePaymentInfo.h"

@implementation DeletePaymentInfo

+(id)deletePaymentInfo:(void (^)(id))success failure:(void (^)(id, NSError *))failure{
    return [self sendDELETERequestForLocation:@"customer/deletepaymentprofile/" 
                                      success:success 
                                      failure:failure];
}

@end
