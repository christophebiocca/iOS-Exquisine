//
//  DeletePaymentInfo.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JSONAPICall.h"

@interface DeletePaymentInfo : JSONAPICall

+(id)deletePaymentInfo:(void (^)(id))success failure:(void (^)(id, NSError *))failure;

@end
