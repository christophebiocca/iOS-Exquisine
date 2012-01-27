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

@implementation PlaceOrder

+(void)sendOrder:(Order*)order toLocation:(Location*)location{
    NSMutableDictionary* placement = [NSMutableDictionary dictionaryWithCapacity:2];
    [placement setObject:[order orderRepresentation] forKey:@"order"];
    [placement setObject:[location primaryKey] forKey:@"location"];
    [self sendPOSTRequestForLocation:@"customer/orders/" 
                        withJSONData:placement 
                             success:^(PlaceOrder* call) {
                                 NSDictionary* newOrder = [call jsonData];
                                 NSLog(@"Placed an order successfully %@", newOrder);
                                 [order setStatus:@"Placed"];
                             } 
                             failure:^(PlaceOrder* call, NSError* error) {
                                 NSLog(@"Couldn't place order %@! %@", call, error);
                             }];
}

@end
