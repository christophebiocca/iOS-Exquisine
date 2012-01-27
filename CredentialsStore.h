//
//  CredentialsStore.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CredentialsStore : NSObject{
    NSString* appID;
    NSString* phoneID;
    NSString* signature;
}

+(CredentialsStore*)credentialsStore;

@property(retain,readonly)NSString* appID;
@property(retain,readonly)NSString* phoneID;
@property(retain,readonly)NSString* signature;

@end
