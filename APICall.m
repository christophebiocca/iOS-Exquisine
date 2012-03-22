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

NSString* SERVER_HTTP_ERROR_DOMAIN = @"com.croutonlabs.server.http";

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
    NSString* serverString;
    
#if DEBUG
    serverString = @"http://staging.croutonlabs.com";
    
     //@"http://10.172.71.61:8000";  //Drew
    
    //@"http://10.172.71.154:8000/";  //Jake
    
    //@"http://staging.croutonlabs.com";  //Staging
#else
    serverString = @"https://croutonlabs.com/";
#endif
    
    serverURL = [NSURL URLWithString:serverString];
    loginURL = [self urlForLocation:@"accounts/login/"];
}

+(id)sendGETRequestForLocation:(NSString*)location withDelegate:(id<APICallDelegate>)delegate{
    __block id<APICallDelegate> theDelegate = delegate;
    return [self sendGETRequestForLocation:location 
                                   success:^(APICall* call){
                                       [theDelegate apiCallCompleted:call];
                                   }
                                   failure:^(APICall* call, NSError* error) {
                                       [theDelegate apiCall:call returnedError:error];
                                   }];
}

+(id)sendDELETERequestForLocation:(NSString *)location withDelegate:(id<APICallDelegate>)delegate{
    __block id<APICallDelegate> theDelegate = delegate;
    return [self sendDELETERequestForLocation:location 
                                      success:^(APICall* call) {
                                          [theDelegate apiCallCompleted:call];
                                      } failure:^(APICall* call, NSError* error) {
                                          [theDelegate apiCall:call returnedError:error];
                                      }];
}

+(id)sendPOSTRequestForLocation:(NSString*)location withBodyData:(NSData*)data withDelegate:(id<APICallDelegate>)delegate{
    __block id<APICallDelegate> theDelegate = delegate;
    return [self sendPOSTRequestForLocation:location 
                               withBodyData:data 
                                    success:^(APICall* call){
                                        [theDelegate apiCallCompleted:call];
                                    } 
                                    failure:^(APICall* call, NSError* error) {
                                        [theDelegate apiCall:call returnedError:error];
                                    }];
}

+(id)sendPOSTRequestForLocation:(NSString*)location withFormData:(NSDictionary*)form andDelegate:(id<APICallDelegate>)delegate{
    __block id<APICallDelegate> theDelegate = delegate;
    return [self sendPOSTRequestForLocation:location 
                               withFormData:form 
                                    success:^(APICall* call){
                                        [theDelegate apiCallCompleted:call];
                                    }
                                    failure:^(APICall* call, NSError* error) {
                                        [theDelegate apiCall:call returnedError:error];
                                    }];
}

+(id)sendGETRequestForLocation:(NSString*)location 
                       success:(void(^)(id))success 
                       failure:(void(^)(id, NSError*))failure{
    APICall* call = [[self alloc] initWithRequest:[self baseRequestForLocation:location] 
                        successBlock:success 
                          errorBlock:failure];
    [call send];
    return call;
}

+(id)sendDELETERequestForLocation:(NSString *)location 
                          success:(void (^)(id))success 
                          failure:(void (^)(id, NSError *))failure{
    NSMutableURLRequest* req = [self baseRequestForLocation:location];
    [req setHTTPMethod:@"DELETE"];
    APICall* call = [[self alloc] initWithRequest:req 
                                     successBlock:success 
                                       errorBlock:failure];
    [call send];
    return call;
}

+(id)sendPOSTRequestForLocation:(NSString*)location 
                   withBodyData:(NSData*)data 
                        success:(void (^)(id))success 
                          failure:(void (^)(id, NSError *))failure{
    APICall* call = [[self alloc] initWithRequest:[self postRequestForLocation:location data:data]
                                        successBlock:success 
                                          errorBlock:failure];
    [call send];
    return call;
}

+(id)sendPOSTRequestForLocation:(NSString*)location 
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
    return [self sendPOSTRequestForLocation:location withBodyData:body success:success failure:failure];
}

+(NSMutableURLRequest*)baseRequestForLocation:(NSString*)location{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey];
    
    location = [NSString stringWithFormat:@"%@?client_version=iphone-monami-%@", location, version];
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
        attemptCounter = 0;
        request = [therequest copy];
        successblock = [theSuccessBlock copy];
        errorblock = [theErrorBlock copy];
    }
    return self;
}

-(void)send{
    if((attemptCounter += 1) >= 5){
        error = [NSError errorWithDomain:@"Too many attempts." code:0 userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:attemptCounter] forKey:@"Attempt count"]];
        errorblock(self, error);
        return;
    }
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
    CLLog(LOG_LEVEL_INFO,[NSString stringWithFormat:@"Got response: %d", status] );
     
    if(status == 403){
        // Most likely a csrf token issue, we can fix it by hitting our favorite url.
        CLLog(LOG_LEVEL_INFO, @"GOING TO ACQUIRE A CSRF TOKEN/COOKIE");
        [connection cancel];
        // Nucleate all the cookies.
        NSHTTPCookieStorage* storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for(NSHTTPCookie* cookie in [storage cookies]){
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
        [APICall sendGETRequestForLocation:@"customer/phoneapplogin/" 
                                   success:^(APICall* cookieRequest) {
                                       CLLog(LOG_LEVEL_INFO, [NSString stringWithFormat:@"token ACQUIRED! %@", cookieRequest]);
                                       [self send];
                                   } 
                                   failure:^(APICall* cookieRequest, NSError* cookieError) {
                                       CLLog(LOG_LEVEL_ERROR, [NSString stringWithFormat:@"The cookie request errored with:\n%@", cookieError]);
                                       // We should do some diagnostics on this, because it shouldn't happen.
                                   }];
    }
}

-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)dataToAdd{
    CLLog(LOG_LEVEL_INFO, [NSString stringWithFormat: @"GOT %d bytes of data", [dataToAdd length]]);
    [data appendData:dataToAdd];
}

-(void)complete{
    CLLog(LOG_LEVEL_INFO, @"Completing");
    NSInteger status = [response statusCode];
    if((status / 100) == 4 || (status / 100) == 5){
        error = [NSError errorWithDomain:SERVER_HTTP_ERROR_DOMAIN
                                    code:status 
                                userInfo:nil];
    }
    completed = YES;
    [self postCompletionHook];
    if(error){
        if([[error domain] isEqualToString:SERVER_HTTP_ERROR_DOMAIN] &&
           ([error code] / 100) == 5){
            CLLog(LOG_LEVEL_ERROR, [NSString stringWithFormat: @"Received a server error:%@", error]);
        }
        errorblock(self, error);
    } else {
        successblock(self);
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)theError{
    CLLog(LOG_LEVEL_ERROR, [NSString stringWithFormat: @"Connection failed with the following error:\n%@", theError]);
    [self setError:theError];
    [self complete];
}

-(void)connectionDidFinishLoading:(NSURLConnection*)connection{
    CLLog(LOG_LEVEL_INFO, @"Finished loading.");
    [self complete];
}

-(NSURLRequest*)connection:(NSURLConnection *)connection 
           willSendRequest:(NSURLRequest *)theRequest 
          redirectResponse:(NSURLResponse *)response{
    NSURL* newURL = [theRequest URL];
    CLLog(LOG_LEVEL_INFO, [NSString stringWithFormat: @"Redirect to: %@ (%@)", newURL, theRequest]);
    if([[newURL pathComponents] isEqualToArray:[loginURL pathComponents]]){
        CLLog(LOG_LEVEL_INFO,@"Killing current connection to server");
        [connection cancel]; // killing current connection.
        [Login login:^(Login* login){
            CLLog(LOG_LEVEL_INFO, [NSString stringWithFormat: @"Following successful login %@, relaunching request %@.", login, self]);
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

-(void)replaceError:(NSError*)replacementError{
    NSAssert(error, @"No existing error!");
    error = replacementError;
}

-(NSData*)rawData{
    NSAssert(completed, @"Can't access raw data before the request completes!");
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
        CLLog(LOG_LEVEL_DEBUG, [NSString stringWithFormat: @"Cookie : %@", cookie]);
        if([[cookie name] isEqualToString:@"csrftoken"]){
            csrfToken = [cookie value];
            break;
        }
    }
    [request addValue:csrfToken forHTTPHeaderField:@"X-CSRFToken"];
}

@end
