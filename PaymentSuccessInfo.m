//
//  PaymentSuccessInfo.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentSuccessInfo.h"

@implementation PaymentSuccessInfo

@synthesize authCode;
@synthesize messageText;
@synthesize trnAmount;
@synthesize trnDate;
@synthesize orderNumber;

-(id)initWithData:(NSDictionary*)data{
    if(self = [super init]){
        
        authCode = [data objectForKey:@"authCode"];
        messageText = [data objectForKey:@"messageText"];
        trnAmount = [data objectForKey:@"trnAmount"];
        trnDate = [data objectForKey:@"trnDate"];
        orderNumber = [NSString stringWithFormat:@"%@",[data objectForKey:@"order_number"]];
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)decoder
{
    authCode = [decoder decodeObjectForKey:@"authCode"];
    messageText = [decoder decodeObjectForKey:@"messageText"];
    trnAmount = [decoder decodeObjectForKey:@"trnAmount"];
    trnDate = [decoder decodeObjectForKey:@"trnDate"];
    orderNumber = [decoder decodeObjectForKey:@"orderNumber"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:authCode forKey:@"authCode"];
    [encoder encodeObject:messageText forKey:@"messageText"];
    [encoder encodeObject:trnAmount forKey:@"trnAmount"];
    [encoder encodeObject:trnDate forKey:@"trnDate"];
    [encoder encodeObject:orderNumber forKey:@"orderNumber"];
}

@end
