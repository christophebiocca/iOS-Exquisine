//
//  Utilities.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Utilities.h"
#import "LocalyticsSession.h"

@implementation Utilities

+(NSString *)FormatToPrice:(NSDecimalNumber*)price
{
    
    if([price isEqual:[NSDecimalNumber zero]])
    {
        return @"Free!";
    }
    return [NSNumberFormatter localizedStringFromNumber:price 
                                            numberStyle:NSNumberFormatterCurrencyStyle];
}

+(NSInteger)CompositeListCount:(NSMutableArray *) compositeList
{
    NSInteger tally = 0;
    
    for (NSMutableArray *compositeMember in compositeList) {
        tally += [compositeMember count];
    }
    
    return tally;
}

+(id)MemberOfCompositeListAtIndex:(NSMutableArray *)compositeList:(NSInteger)anInt
{
    if (compositeList == nil) {
        return nil;
    }
    int indicesLeft = anInt + 1;
    int membersTraversed = 0;
    
    while (indicesLeft > 0)
    {
        if([[compositeList objectAtIndex:membersTraversed]count] >= indicesLeft)
            return [[compositeList objectAtIndex:membersTraversed] objectAtIndex:(indicesLeft-1)];
        indicesLeft -= [[compositeList objectAtIndex:membersTraversed]count];
        membersTraversed ++;
    }
    return nil;
}

+(void)logLevel:(LogLevel)level message:(NSString *)message
{
    #if INFO && DEBUG
    switch (level) {
        case LOG_LEVEL_INFO:
            NSLog(@"INFO: %@",message);
            break;
        case LOG_LEVEL_DEBUG:
            NSLog(@"DEBUG: %@",message);
            break;
        case LOG_LEVEL_WARNING:
            NSLog(@"WARNING: %@",message);
            break;
        case LOG_LEVEL_ERROR:
            NSLog(@"ERROR: %@",message);
            break;
            
        default:
            break;
    }
    #elif DEBUG
    
    switch (level) {
        case LOG_LEVEL_DEBUG:
            NSLog(@"DEBUG: %@",message);
            break;
        case LOG_LEVEL_WARNING:
            NSLog(@"WARNING: %@",message);
            break;
        case LOG_LEVEL_ERROR:
            NSLog(@"ERROR: %@",message);
            break;
            
        default:
            break;
    }
    #else
    switch (level) {
        case LOG_LEVEL_WARNING:
            [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"WARNING encountered:" attributes:[NSDictionary dictionaryWithObject:message forKey:@"message"]];
            break;
        case LOG_LEVEL_ERROR:
            [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"ERROR encountered:" attributes:[NSDictionary dictionaryWithObject:message forKey:@"message"]];
            break;
            
        default:
            break;
    }
    #endif
}

+(NSString*)uuid{
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString* uuidString = [(__bridge_transfer NSString*) CFUUIDCreateString(kCFAllocatorDefault, uuid) lowercaseString];
    CFRelease(uuid);
    return uuidString;
}

@end
