//
//  OpeningHours.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OpeningHours.h"

@implementation OpeningHours

@synthesize isOpen, opens, closes;

static NSRegularExpression* hoursParser;
static NSArray* weekdays;
+(void)initialize{
    if(!hoursParser){
        NSError* error = nil;
        NSString* pattern = @"\\A(\\d{2}):(\\d{2}):(\\d{2})\\Z";
        hoursParser = [NSRegularExpression 
                       regularExpressionWithPattern:pattern
                       options:0 
                       error:&error];
        if(error){
            NSAssert(!error, @"INVALID REGEX (%@)? UNACCEPTABLE.", pattern);
        }
    }
    if(!weekdays){
        weekdays = [NSArray arrayWithObjects:@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", nil];
    }
}

-(id)initWithData:(NSDictionary*)data day:(NSString*)dayName{
    if(self = [super init]){
        isOpen = [[data objectForKey:@"is_open"] isEqualToString:@"True"];
        {
            NSString* openString = [data objectForKey:@"opens"];
            NSTextCheckingResult* match = [hoursParser firstMatchInString:openString 
                                                                  options:0 
                                                                    range:NSMakeRange(0, [openString length])];
            opens = [[NSDateComponents alloc] init];
            [opens setHour:[[openString substringWithRange:[match rangeAtIndex:1]] intValue]];
            [opens setMinute:[[openString substringWithRange:[match rangeAtIndex:2]] intValue]];
            [opens setSecond:[[openString substringWithRange:[match rangeAtIndex:3]] intValue]];
        }
        {
            NSString* closeString = [data objectForKey:@"closes"];
            NSTextCheckingResult* match = [hoursParser firstMatchInString:closeString 
                                                                  options:0 
                                                                    range:NSMakeRange(0, [closeString length])];
            closes = [[NSDateComponents alloc] init];
            [closes setHour:[[closeString substringWithRange:[match rangeAtIndex:1]] intValue]];
            [closes setMinute:[[closeString substringWithRange:[match rangeAtIndex:2]] intValue]];
            [closes setSecond:[[closeString substringWithRange:[match rangeAtIndex:3]] intValue]];
        }
        day = [weekdays indexOfObject:dayName];
    }
    return self;
}

- (OpeningHours *)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        day = [[decoder decodeObjectForKey:@"day"] intValue];
        isOpen = [[decoder decodeObjectForKey:@"isOpen"] intValue];
        opens = [decoder decodeObjectForKey:@"opens"];
        closes = [decoder decodeObjectForKey:@"closes"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:[NSNumber numberWithInt:day] forKey:@"day"];
    [encoder encodeObject:[NSNumber numberWithInt:isOpen] forKey:@"isOpen"];
    [encoder encodeObject:opens forKey:@"opens"];
    [encoder encodeObject:closes forKey:@"closes"];
}

@end
