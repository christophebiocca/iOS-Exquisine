//
//  JSONAPICall.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "APICall.h"
#import "APICallProtectedMethods.h"

@interface JSONAPICall : APICall{
    @private
    NSDictionary* jsonData;
}

+(void)sendPOSTRequestForLocation:(NSString *)location withJSONData:(NSDictionary *)json andDelegate:(id<APICallDelegate>)delegate;
+(void)sendPOSTRequestForLocation:(NSString *)location withJSONData:(NSDictionary *)form 
                          success:(void (^)(APICall *))success 
                          failure:(void (^)(APICall *, NSError *))failure;

@property(retain, readonly)NSDictionary* jsonData;

@end
