//
//  APICall.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "APICall.h"
#import "APICallProtectedMethods.h"
#import "APICallDelegate.h"

@interface APICall(PrivateMethods)

-(void)invokeCallbacks;
+(NSURL*)urlForLocation:(NSString*)location;
+(NSMutableURLRequest*)baseRequestForLocation:(NSString*)location;
+(NSMutableURLRequest*)postRequestForLocation:(NSString*)location data:(NSData*)data;
-(void)send;
-(void)postCompletionHook;
-(void)setDelegate:(id<APICallDelegate>)delegate;
-(id)initWithRequest:(NSURLRequest*)request successBlock:(void (^)(APICall*))success errorBlock:(void (^)(APICall*, NSError*))error;

@end

@implementation APICall

@synthesize completed;

+(void)sendGETRequestForLocation:(NSString*)location withDelegate:(id<APICallDelegate>)delegate{
    __block id<APICallDelegate> theDelegate = delegate;
    [self sendGETRequestForLocation:location 
                            success:^(APICall* call){
                                [theDelegate apiCallCompleted:call];
                            }
                            failure:^(APICall* call, NSError* error) {
                                [theDelegate apiCall:call returnedError:error];
                            }];
}

+(void)sendPOSTRequestForLocation:(NSString*)location withBodyData:(NSData*)data withDelegate:(id<APICallDelegate>)delegate{
    __block id<APICallDelegate> theDelegate = delegate;
    [self sendPOSTRequestForLocation:location 
                        withBodyData:data 
                             success:^(APICall* call){
                                 [theDelegate apiCallCompleted:call];
                             } 
                             failure:^(APICall* call, NSError* error) {
                                 [theDelegate apiCall:call returnedError:error];
                             }];
}

+(void)sendPOSTRequestForLocation:(NSString*)location withFormData:(NSDictionary*)form andDelegate:(id<APICallDelegate>)delegate{
    __block id<APICallDelegate> theDelegate = delegate;
    [self sendPOSTRequestForLocation:location 
                        withFormData:form 
                             success:^(APICall* call){
                                 [theDelegate apiCallCompleted:call];
                             }
                             failure:^(APICall* call, NSError* error) {
                                 [theDelegate apiCall:call returnedError:error];
                             }];
}

+(void)sendGETRequestForLocation:(NSString*)location 
                         success:(void(^)(id))success 
                         failure:(void(^)(id, NSError*))failure{
    APICall* call = [[self alloc] initWithRequest:[self baseRequestForLocation:location] 
                        successBlock:success 
                          errorBlock:failure];
    [call send];
}

+(void)sendPOSTRequestForLocation:(NSString*)location 
                     withBodyData:(NSData*)data 
                          success:(void (^)(id))success 
                          failure:(void (^)(id, NSError *))failure{
    APICall* call = [[self alloc] initWithRequest:[self postRequestForLocation:location data:data]
                                        successBlock:success 
                                          errorBlock:failure];
    [call send];
}

+(void)sendPOSTRequestForLocation:(NSString*)location 
                     withFormData:(NSDictionary*)form 
                          success:(void (^)(id))success 
                          failure:(void (^)(id, NSError *))failure{
    __block NSMutableString* buffer = [[NSMutableString alloc] init];
    __block NSInteger index = 0;
    [form enumerateKeysAndObjectsUsingBlock:^(NSString* key, id obj, BOOL* stop){
        if(![obj conformsToProtocol:@protocol(NSFastEnumeration)]){
            obj = [NSArray arrayWithObject:obj];
        }
        for(id value in obj){
            if(index++){
                [buffer appendString:@"&"];
            }
            [buffer appendString:key];
            [buffer appendFormat:@"="];
            [buffer appendFormat:value];
        }
    }];
    NSData* body = [buffer dataUsingEncoding:NSASCIIStringEncoding];
    [self sendPOSTRequestForLocation:location withBodyData:body success:success failure:failure];
}

+(NSMutableURLRequest*)baseRequestForLocation:(NSString*)location{
    NSURL* requestURL = [self urlForLocation:location];
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:requestURL];
    return req;
}

+(NSMutableURLRequest*)postRequestForLocation:(NSString*)location data:(NSData*)data{
    NSURL* requestURL = [self urlForLocation:location];
    NSMutableURLRequest* req = [self baseRequestForLocation:location];
    [req setHTTPMethod:@"POST"];
    NSString* csrfToken = nil;
    NSArray* cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:requestURL];
    for(NSHTTPCookie* cookie in cookies){
        NSLog(@"Cookie : %@", cookie);
        if([[cookie name] isEqualToString:@"csrftoken"]){
            csrfToken = [cookie value];
            break;
        }
    }
    [req addValue:csrfToken forHTTPHeaderField:@"X-CSRFToken"];
    return req;
}

-(id)initWithRequest:(NSURLRequest*)therequest 
        successBlock:(void (^)(APICall *))theSuccessBlock 
          errorBlock:(void (^)(APICall *, NSError *))theErrorBlock{
    if((self = [super init])){
        request = therequest;
        successblock = [theSuccessBlock copy];
        errorblock = [theErrorBlock copy];
    }
    return self;
}

-(void)send{
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue] 
                           completionHandler:[^(NSURLResponse* theResponse, NSData* theData, NSError* theError){
        response = theResponse;
        data = theData;
        error = theError;
        completed = YES;
        [self postCompletionHook];
        if(error){
            errorblock(self, error);
        } else {
            successblock(self);
        }
    } copy]];
}

-(void)postCompletionHook{
    // The default is to do nothing.
}

-(NSError*)error{
    NSAssert(completed, @"Can't look at error before the request completes!");
    return error;
}

-(void)setError:(NSError*)theError{
    NSAssert(!error, @"We already have an error!");
    error = theError;
}

-(NSData*)rawData{
    NSAssert(completed, @"Can't access raw data before the request completes!");
    NSAssert(!error, @"Can't access raw data, we have an error!");
    return data;
}

+(NSURL*)urlForLocation:(NSString*)location{
    NSString *testingServer = @"http://localhost:8000";
    NSString *productionServer = @"http://croutonlabs.com";
    
    NSURL* serverURL = [NSURL URLWithString:productionServer];
    return [NSURL URLWithString:location relativeToURL:serverURL];
}

@end
