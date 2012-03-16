//
//  NSMutableNumber.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSMutableNumber.h"

NSString *NUMBER_MODIFIED = @"NUMBER_MODIFIED";

@implementation NSMutableNumber

-(id)initWithNumber:(NSNumber *)aNumber
{
    self = [super init];
    
    if(self)
    {
        theNumber = aNumber;
    }
    
    return self;
}

-(void)addNumber:(NSNumber *)aNumber
{
    theNumber = [NSNumber numberWithInt:([aNumber intValue] + [theNumber intValue])];
    [[NSNotificationCenter defaultCenter] postNotificationName:NUMBER_MODIFIED object:self];
}

-(int)intValue
{
    return [theNumber intValue];
}

-(NSString *)stringValue
{
    return [theNumber stringValue];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    
    if(self)
    {
        theNumber = [decoder decodeObjectForKey:@"the_number"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:theNumber forKey:@"the_number"];
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@", theNumber];
}

@end
