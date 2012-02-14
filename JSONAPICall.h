//
//  JSONAPICall.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "APICall.h"
#import "APICallProtectedMethods.h"

extern NSString* JSON_API_ERROR;

@interface JSONAPICall : APICall{
    @private
    NSDictionary* jsonData;
}

+(id)sendPOSTRequestForLocation:(NSString *)location withJSONData:(NSDictionary *)json andDelegate:(id<APICallDelegate>)delegate;
+(id)sendPOSTRequestForLocation:(NSString *)location withJSONData:(NSDictionary *)form 
                        success:(void (^)(id))success 
                        failure:(void (^)(id, NSError *))failure;

@property(retain, readonly)NSDictionary* jsonData;

@end
