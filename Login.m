//
//  Login.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Login.h"
#import "APICallProtectedMethods.h"
#import "CredentialsStore.h"

static NSString* redirectSuccessString = @"/ArbitraryValidStaticUrlPath";

@implementation Login

+(void)login:(void (^)(id))success{
    CredentialsStore* store = [CredentialsStore credentialsStore];
    NSDictionary* formData = [NSDictionary dictionaryWithObjectsAndKeys:
                              [store appID], @"app_id",
                              [store phoneID], @"phone_id",
                              [store signature], @"signature",
                              nil];
    success = [success copy];
    [self sendPOSTRequestForLocation:[NSString stringWithFormat:@"customer/phoneapplogin/?next=%@", redirectSuccessString]
                        withFormData:formData 
                             success:^(Login* login){
                                 success(login);
                             }
                             failure:^(Login* login, NSError* error) {
                                 CLLog(LOG_LEVEL_ERROR ,[NSString stringWithFormat: @"Serious issues here, can't login apparently.\n%@", error]);
                             }];
}

// Check if we have a redirect for success.
-(NSURLRequest*)connection:(NSURLConnection *)connection 
           willSendRequest:(NSURLRequest *)request 
          redirectResponse:(NSURLResponse *)response{
    if([(NSHTTPURLResponse*)response statusCode] == 302){
        NSString* path = [[request URL] path];
        CLLog(LOG_LEVEL_INFO, [NSString stringWithFormat: @"Redirection %@", path]);
        if([path isEqualToString:redirectSuccessString]){
            [connection cancel];
            [self complete];
            return nil;
        }
    }
    return [super connection:connection willSendRequest:request redirectResponse:response];
}

@end
