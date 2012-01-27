//
//  Login.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Login.h"
#import "CredentialsStore.h"

@implementation Login

+(void)login:(void (^)(id))success{
    CredentialsStore* store = [CredentialsStore credentialsStore];
    NSDictionary* formData = [NSDictionary dictionaryWithObjectsAndKeys:
                              [store appID], @"app_id",
                              [store phoneID], @"phone_id",
                              [store signature], @"signature",
                              nil];
    success = [success copy];
    [self sendPOSTRequestForLocation:@"customer/phoneapplogin/" 
                        withFormData:formData 
                             success:^(Login* login){
                                 success(login);
                             }
                             failure:^(Login* login, NSError* error) {
                                 NSLog(@"Serious issues here, can't login apparently.\n%@", error);
                             }];
}

@end
