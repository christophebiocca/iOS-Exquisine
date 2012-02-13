//
//  CredentialsStore.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CredentialsStore.h"
#import <Security/Security.h>
#import <CommonCrypto/CommonDigest.h>

@implementation CredentialsStore

static CredentialsStore* store = nil;
+(void)initialize{
    if(!store){
        store = [[CredentialsStore alloc] init];
    }
}

+(CredentialsStore*)credentialsStore{
    return store;
}

-(void)obtainSecureAppID{
    CFStringRef accessKey = (CFStringRef) @"Exquisine - Security Key";
    CFStringRef serviceKey = (CFStringRef) @"service";
    CFMutableDictionaryRef searchDict = 
    CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFDictionaryAddValue(searchDict, kSecClass, kSecClassGenericPassword);
    CFDictionaryAddValue(searchDict, kSecAttrService, serviceKey);
    CFDictionaryAddValue(searchDict, kSecAttrAccount, accessKey);
    CFDictionaryAddValue(searchDict, kSecReturnData, kCFBooleanTrue);
    
    CFDataRef data = nil;
    OSStatus res = SecItemCopyMatching(searchDict, (CFTypeRef*)&data);
    if(res == errSecSuccess){
        appID = [[[NSString alloc] initWithData:(__bridge NSData*)data encoding:NSASCIIStringEncoding] lowercaseString];
        CFRelease(data);
    } else if(res == errSecItemNotFound){
        // Create it.
        NSString* uuidString = [Utilities uuid];
        CFDataRef data = (__bridge CFDataRef)[uuidString dataUsingEncoding:NSASCIIStringEncoding];
        CFDictionaryRemoveValue(searchDict, kSecReturnData);
        CFDictionaryAddValue(searchDict, kSecAttrAccessible, kSecAttrAccessibleAfterFirstUnlock);
        CFDictionaryAddValue(searchDict, kSecValueData, data);
        res = SecItemAdd(searchDict, NULL);
        if(res == errSecSuccess){
            appID = uuidString;
        } else {
            NSAssert(NO, @"WTF GENTLEMEN, we got this %ld", res);   
        }
    } else {
        NSAssert(NO, @"WTF GENTLEMEN, we got this %ld", res);
    }
    CFRelease(searchDict);
}

-(NSString*)appID{
    if(!appID){
        // Fetch it from the secure chain
        [self obtainSecureAppID];
    }
    return appID;
}

// We need to start thinking whether we should be collecting phone ids at all,
// they're useless for authentication, and apple considers them deprecated.
-(NSString*)phoneID{
    if(!phoneID){
        phoneID = [[UIDevice currentDevice] performSelector:@selector(uniqueIdentifier)];
    }
    return phoneID;
}

static NSString* signingString = @"THIS IS A TEST GUYS";
-(NSString*)signature{
    if(!signature){
        NSData* dataToHash = [[NSString stringWithFormat:@"%@%@%@", 
                              [self appID], 
                              [self phoneID], 
                              signingString] dataUsingEncoding:NSASCIIStringEncoding];
        unsigned char hash[CC_SHA512_DIGEST_LENGTH];
        CC_SHA512([dataToHash bytes], [dataToHash length], hash);
        NSMutableString* hexHash = [NSMutableString string];
        for(NSInteger i = 0; i < CC_SHA512_DIGEST_LENGTH; ++i){
            [hexHash appendFormat:@"%02x", hash[i]];
        }
        signature = hexHash;
    }
    return signature;
}

@end
