//
//  JSONAPICall.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JSONAPICall.h"

NSString* JSON_API_ERROR = @"com.croutonlabs.server.json";

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

+(id)sendPOSTRequestForLocation:(NSString *)location withJSONData:(NSDictionary *)json andDelegate:(id<APICallDelegate>)delegate{
    return [self sendPOSTRequestForLocation:location 
                               withBodyData:[self getJSONData:json]
                               withDelegate:delegate];
}

+(id)sendPOSTRequestForLocation:(NSString *)location withJSONData:(NSDictionary *)json 
                        success:(void (^)(id))success 
                        failure:(void (^)(id, NSError *))failure{
    return [self sendPOSTRequestForLocation:location 
                               withBodyData:[self getJSONData:json]
                                    success:success 
                                    failure:failure];
}

-(void)postCompletionHook{
    [super postCompletionHook];
    NSError* parsingError = nil;
    CLLog(LOG_LEVEL_INFO, [NSString stringWithFormat:@"Parsing JSON: \n%@", [[NSString alloc] initWithData:[self rawData] encoding:NSASCIIStringEncoding]]);
    NSDictionary* parsed = [NSJSONSerialization JSONObjectWithData:[self rawData] 
                                                           options:0 
                                                             error:&parsingError];
    NSError* originalError = [self error];
    if(parsingError){
        if(!originalError){
            [self setError:parsingError];
        }
    } else if(originalError && // Bad requests usually have a parsable json explanation attached to them.
              [originalError domain] == SERVER_HTTP_ERROR_DOMAIN &&
              [originalError code] == 400){
        NSDictionary* errorObject = [parsed objectForKey:@"error"];
        if(errorObject){
            [self replaceError:[NSError errorWithDomain:JSON_API_ERROR code:0 userInfo:errorObject]];
        }
    } else {
        jsonData = parsed;
    }
}

-(NSDictionary*)jsonData{
    NSAssert([self completed], @"Can't access jsonData before request completes!");
    NSAssert(![self error], @"Can't access jsonData when there is an error!");
    return jsonData;
}

@end
