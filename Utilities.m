//
//  Utilities.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Utilities.h"
#import "LocalyticsSession.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation Utilities

+(NSString *)FormatToPrice:(NSDecimalNumber*)price
{
    
    if([price isEqual:[NSDecimalNumber zero]])
    {
        return @"$0";
    }
    return [NSNumberFormatter localizedStringFromNumber:price 
                                            numberStyle:NSNumberFormatterCurrencyStyle];
}

+(NSString *)FormatToDate:(NSDate *) theDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a, EEE, MMM dd, yyyy"];
    
    return [formatter stringFromDate:theDate]; 
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

+(void)playSound:(NSString *)fName
{
    SystemSoundID aSoundID;
    
    NSString *filePathString = [[NSBundle mainBundle] 
                            pathForResource:fName ofType:@"wav"];   
    OSStatus error = 
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:filePathString], &aSoundID);
    if (!error == kAudioServicesNoError) { // success
        CLLog(LOG_LEVEL_ERROR, @"A sound file did not load properly.");
    }
    
    /* Play */
    AudioServicesPlaySystemSound(aSoundID);
    
    /* Dispose */
    //AudioServicesDisposeSystemSoundID(aSoundID);
}

+(UIFont *) fravicHeadingFont
{
    return [UIFont fontWithName:@"AmericanTypewriter-Bold" size:16]; //[UIFont fontWithName:@"ArialHebrew-Bold" size:18];
}

+(UIFont *) fravicTextFont
{
    return [UIFont fontWithName:@"AmericanTypewriter" size:12]; //[UIFont fontWithName:@"ArialHebrew" size:14];
}

+(UIColor *)fravicDarkRedColor
{
    return [UIColor colorWithRed:(134.0f/255.0f) green:(7.0f/255.0f) blue:(6.0f/255.0f) alpha:1];
}

+(UIColor *)fravicDarkPinkColor
{
    return [UIColor colorWithRed:(250.0/255.0) green:(208.0/255.0) blue:(208.0/255.0) alpha:1.0];
}

+(UIColor *)fravicLightPinkColor
{
    return [UIColor colorWithRed:(251.0/255.0) green:(228.0/255.0) blue:(228.0/255.0) alpha:1.0];
}


@end
