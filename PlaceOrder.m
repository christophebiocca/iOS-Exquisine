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
    NSMutableDictionary* placement = [NSMutableDictionary dictionaryWithCapacity:3];
    [placement setObject:[order orderRepresentation] forKey:@"order"];
    [placement setObject:[location primaryKey] forKey:@"location"];
    NSDictionary* payment = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"4030 0000 1000 1234", @"cardnumber",
                             @"Bob Dude", @"cardholder_name",
                             [NSNumber numberWithInt:11], @"expiry_month",
                             [NSNumber numberWithInt:2013], @"expiry_year",
                             nil];
    [placement setObject:payment forKey:@"payment"];
    
    [self sendPOSTRequestForLocation:@"customer/orders/" 
                        withJSONData:placement 
                             success:^(PlaceOrder* call) {
                                 NSDictionary* newOrder = [call jsonData];
                                 DebugLog(@"Placed an order successfully %@", newOrder);
                                 [order setStatus:@"Placed"];
                             } 
                             failure:^(PlaceOrder* call, NSError* error) {
                                 NSLog(@"Couldn't place order %@! %@", call, error);
                             }];
}

@end
