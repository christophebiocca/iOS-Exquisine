//
//  APICall.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "APICall.h"
#import "APICallDelegate.h"

@interface APICall(PrivateMethods)

-(void)invokeCallbacks;
+(NSURL*)urlForLocation:(NSString*)location;

@end

@implementation APICall

-(id)initGETRequestForLocation:(NSString*)location{
    if((self = [super init])){
        NSURLRequest* req = [NSURLRequest requestWithURL:[APICall urlForLocation:location]];
        [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:[^(NSURLResponse* resp, NSData* data, NSError* returnError){
            @synchronized(self){
                if(data){
                    returnValue = [NSJSONSerialization JSONObjectWithData:data 
                                                                  options:0 
                                                                    error:&returnError];
                }
                error = returnError;
                if(delegate){
                    [self invokeCallbacks];
                }
            }
        } copy]];
    }
    return self;
}

-(id)initPOSTRequestForLocation:(NSString*)location andJSONData:(NSDictionary*)jsonData{
    if((self = [super init])){
        // TODO: implement this.
    }
    return self;
}

-(void)setDelegate:(id<APICallDelegate>)delegateToSet{
    @synchronized(self){
        delegate = delegateToSet;
        if(returnValue || error){
            [self invokeCallbacks];
        }
    }
}

-(void)invokeCallbacks{
    if(error){
        [delegate apiCall:self returnedError:error];
    } else {
        [delegate apiCall:self completedWithData:returnValue];
    }
}

+(NSURL*)urlForLocation:(NSString*)location{
    NSString *testingServer = @"http://localhost:8000";
    NSString *productionServer = @"http://croutonlabs.com";
    
    NSURL* serverURL = [NSURL URLWithString:productionServer];
    return [NSURL URLWithString:location relativeToURL:serverURL];
}

@end
