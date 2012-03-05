//
//  APICall.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@protocol APICallDelegate;

extern NSString* SERVER_HTTP_ERROR_DOMAIN;

@interface APICall : NSObject<NSURLConnectionDataDelegate> {
    @private
    BOOL completed;
    
    NSInteger attemptCounter;
    
    NSMutableURLRequest* request;
    NSHTTPURLResponse* response;
    
    NSError* error;
    NSMutableData* data;
    
    void (^successblock)(APICall*);
    void (^errorblock)(APICall*, NSError*);
}

+(id)sendGETRequestForLocation:(NSString*)location withDelegate:(id<APICallDelegate>)delegate;
+(id)sendDELETERequestForLocation:(NSString*)location withDelegate:(id<APICallDelegate>)delegate;
+(id)sendPOSTRequestForLocation:(NSString*)location withBodyData:(NSData*)data withDelegate:(id<APICallDelegate>)delegate;
+(id)sendPOSTRequestForLocation:(NSString*)location withFormData:(NSDictionary*)form andDelegate:(id<APICallDelegate>)delegate;

+(id)sendGETRequestForLocation:(NSString*)location 
                         success:(void(^)(id))success 
                         failure:(void(^)(id, NSError*))failure;
+(id)sendDELETERequestForLocation:(NSString*)location 
                       success:(void(^)(id))success 
                       failure:(void(^)(id, NSError*))failure;
+(id)sendPOSTRequestForLocation:(NSString*)location 
                     withBodyData:(NSData*)data 
                          success:(void (^)(id))success
                          failure:(void(^)(id, NSError*))failure;
+(id)sendPOSTRequestForLocation:(NSString*)location 
                     withFormData:(NSDictionary*)form 
                          success:(void (^)(id))success
                          failure:(void(^)(id, NSError*))failure;

@property(readonly)BOOL completed;
@property(retain,readonly)NSError* error;
@property(retain,readonly)NSData* rawData;
@property(retain,readonly)NSHTTPURLResponse* response;
@property(retain,readonly)NSURLRequest* request;

@end
