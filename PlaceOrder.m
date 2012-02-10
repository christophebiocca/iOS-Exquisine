//
//  PlaceOrder.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlaceOrder.h"
#import "APICall.h"
#import "Order.h"
#import "Location.h"
#import "PaymentInfo.h"
#import "PaymentSuccessInfo.h"
#import "PaymentError.h"

@implementation PlaceOrder

+(void)sendOrder:(Order*)order toLocation:(Location*)location 
 withPaymentInfo:(PaymentInfo*)paymentInfo
  paymentSuccess:(void(^)(PaymentSuccessInfo*))successBlock
  paymentFailure:(void(^)(PaymentError*))errorBlock{
    NSMutableDictionary* placement = [NSMutableDictionary dictionaryWithCapacity:3];
    [placement setObject:[order orderRepresentation] forKey:@"order"];
    [placement setObject:[location primaryKey] forKey:@"location"];
    [placement setObject:[paymentInfo dictionaryRepresentation] forKey:@"payment"];
    
    [self sendPOSTRequestForLocation:@"customer/orders/" 
                        withJSONData:placement 
                             success:^(PlaceOrder* call) {
                                 PaymentSuccessInfo* successInfo = 
                                 [[PaymentSuccessInfo alloc] initWithData:[call jsonData]];
                                 CLLog(LOG_LEVEL_INFO, [NSString stringWithFormat:@"Placed an order successfully %@", successInfo]);
                                 [order placedWithTransactionInfo:successInfo];
                                 successBlock(successInfo);
                             } 
                             failure:^(PlaceOrder* call, NSError* error) {
                                 CLLog(LOG_LEVEL_WARNING, [NSString stringWithFormat: @"Couldn't place order %@! %@", call, error]);
                                 errorBlock([[PaymentError alloc] initWithCause:error]);
                             }];
    [order submit];
}

@end
