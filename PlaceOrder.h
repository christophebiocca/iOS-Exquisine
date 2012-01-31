//
//  PlaceOrder.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JSONAPICall.h"

@class Order;
@class Location;
@class PaymentInfo;

@interface PlaceOrder : JSONAPICall {
    Order* order;
}

+(void)sendOrder:(Order*)order toLocation:(Location*)location withPaymentInfo:(PaymentInfo*)paymentInfo;

@end
