//
//  JSONAPICall.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JSONAPICall.h"

@implementation JSONAPICall

+(NSData*)getJSONData:(id)object{
    NSError* error = nil;
    NSData* jsonData = [NSJSONSerialization 
                        dataWithJSONObject:object 
                        options:0 
                        error:&error];
    NSAssert(!error, @"INVALID JSON, WHAT ARE YOU? A MONKEY?");
    return jsonData;
}

+(void)sendPOSTRequestForLocation:(NSString *)location withJSONData:(NSDictionary *)json andDelegate:(id<APICallDelegate>)delegate{
    [self sendPOSTRequestForLocation:location 
                        withBodyData:[self getJSONData:json]
                        withDelegate:delegate];
}

+(void)sendPOSTRequestForLocation:(NSString *)location withJSONData:(NSDictionary *)json 
                          success:(void (^)(APICall *))success 
                          failure:(void (^)(APICall *, NSError *))failure{
    [self sendPOSTRequestForLocation:location 
                        withBodyData:[self getJSONData:json]
                             success:success 
                             failure:failure];
}

-(void)postCompletionHook{
    if(!jsonData){
        NSError* parsingError = nil;
        jsonData = [NSJSONSerialization JSONObjectWithData:[self rawData] 
                                                    options:0 
                                                     error:&parsingError];
        if(parsingError){
            [self setError:parsingError];
        }
    }
}

-(NSDictionary*)jsonData{
    NSAssert([self completed], @"Can't access jsonData before request completes!");
    NSAssert(![self error], @"Can't access jsonData when there is an error!");
    return jsonData;
}

@end
