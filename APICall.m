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
#import "Login.h"

@interface APICall(PrivateMethods)

-(void)invokeCallbacks;
+(NSURL*)urlForLocation:(NSString*)location;
+(NSMutableURLRequest*)baseRequestForLocation:(NSString*)location;
+(NSMutableURLRequest*)postRequestForLocation:(NSString*)location data:(NSData*)data;
-(void)send;
-(void)setCSRFToken;
-(void)postCompletionHook;
-(void)setDelegate:(id<APICallDelegate>)delegate;
-(id)initWithRequest:(NSURLRequest*)request successBlock:(void (^)(APICall*))success errorBlock:(void (^)(APICall*, NSError*))error;

@end

@implementation APICall

@synthesize completed, request, response;

static NSURL* loginURL;
static NSURL* serverURL;

+(void)initialize{
    NSString* testingServer = @"http://10.42.43.1:8000";
    NSString* productionServer = @"http://croutonlabs.com";
    serverURL = [NSURL URLWithString:testingServer];
    loginURL = [self urlForLocation:@"accounts/login/"];
}

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
    NSMutableURLRequest* req = [self baseRequestForLocation:location];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:data];
    return req;
}

-(id)initWithRequest:(NSMutableURLRequest*)therequest 
        successBlock:(void (^)(APICall *))theSuccessBlock 
          errorBlock:(void (^)(APICall *, NSError *))theErrorBlock{
    if((self = [super init])){
        request = [therequest copy];
        successblock = [theSuccessBlock copy];
        errorblock = [theErrorBlock copy];
    }
    return self;
}

-(void)send{
    [self setCSRFToken];
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    completed = NO;
    error = nil;
    response = nil;
    data = [[NSMutableData alloc] initWithLength:0];
    [connection start];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)theResponse{
    response = (NSHTTPURLResponse*) theResponse;
    NSInteger status = [response statusCode];
    DebugLog(@"Got response: %d", status);
    if(status == 403){
        // Most likely a csrf token issue, we can fix it by hitting our favorite url.
        DebugLog(@"GOING TO ACQUIRE A CSRF TOKEN/COOKIE");
        [connection cancel];
        [APICall sendGETRequestForLocation:@"customer/phoneapplogin/" 
                                   success:^(APICall* cookieRequest) {
                                       DebugLog(@"token ACQUIRED! %@", cookieRequest);
                                       [self send];
                                   } 
                                   failure:^(APICall* cookieRequest, NSError* cookieError) {
                                       DebugLog(@"OK, at this stage, we are well and truly fucked. %@", cookieError);
                                       // We should do some diagnostics on this, because it shouldn't happen.
                                   }];
    }
}

-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)dataToAdd{
    DebugLog(@"GOT %d bytes of data", [dataToAdd length]);
    [data appendData:dataToAdd];
}

-(void)complete{
    #ifdef DEBUG
    if([response statusCode] == 500){
        DebugLog(@"OMG SERVER ERROR\n%@", [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding]);
    }
    #endif
    DebugLog(@"Completing");
    completed = YES;
    [self postCompletionHook];
    if(error){
        errorblock(self, error);
    } else {
        successblock(self);
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)theError{
    DebugLog(@"HOLY SHIT GUYS WE HAVE AN ERROR!\n%@", theError);
    error = theError;
}

-(void)connectionDidFinishLoading:(NSURLConnection*)connection{
    DebugLog(@"Finished loading.");
    [self complete];
}

-(NSURLRequest*)connection:(NSURLConnection *)connection 
           willSendRequest:(NSURLRequest *)theRequest 
          redirectResponse:(NSURLResponse *)response{
    NSURL* newURL = [theRequest URL];
    DebugLog(@"REDIRECT TO %@ (%@)", newURL, theRequest);
    if([[newURL pathComponents] isEqualToArray:[loginURL pathComponents]]){
        DebugLog(@"HOLY SHIT GUYS WE SHOULD LOGIN!");
        [connection cancel]; // No point in trying anymore, it's fucked.
        [Login login:^(Login* login){
            DebugLog(@"Following successful login %@, relaunching request %@.", login, self);
            [self send];
        }];
    }
    return theRequest;
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
    return [NSURL URLWithString:location relativeToURL:serverURL];
}

-(void)setCSRFToken{
    if(![[request HTTPMethod] isEqualToString:@"POST"]){
        return;
    }
    NSString* csrfToken = nil;
    NSArray* cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[request URL]];
    for(NSHTTPCookie* cookie in cookies){
        DebugLog(@"Cookie : %@", cookie);
        if([[cookie name] isEqualToString:@"csrftoken"]){
            csrfToken = [cookie value];
            break;
        }
    }
    [request addValue:csrfToken forHTTPHeaderField:@"X-CSRFToken"];
}

@end
