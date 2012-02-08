//
//  PaymentProfileInfo.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaymentProfileInfo : NSObject{
    NSString* last4Digits;
}

-(id)initWithData:(NSDictionary*)data;

@property(retain, readonly)NSString* last4Digits;

@end
