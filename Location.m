//
//  Location.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Location.h"
#import "OpeningHours.h"

@implementation Location

@synthesize primaryKey;

static NSDateComponents* oneDay;
static NSDateComponents* minusOneDay;

+(void)initialize{
    if(!oneDay){
        oneDay = [[NSDateComponents alloc] init];
        [oneDay setDay:1];
    }
    if(!minusOneDay){
        minusOneDay = [[NSDateComponents alloc] init];
        [minusOneDay setDay:-1];
    }
}

-(id)initFromData:(NSDictionary*)inputData{
    if(self = [super init]){
        primaryKey = [inputData objectForKey:@"pk"];
        NSDictionary* hoursDict = [inputData objectForKey:@"hours"];
        NSMutableArray* hours = [NSMutableArray arrayWithCapacity:7];
        [hoursDict enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSDictionary* obj, BOOL *stop) {
            [hours addObject:[[OpeningHours alloc] initWithData:obj day:key]];
        }];
        [hours sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"day" ascending:YES]]];
        storeHours = hours;
        lastCall = 900;
    }
    return self;
}

+(NSDate*)mergeComponents:(NSDateComponents*)components withDate:(NSDate*)date{
    NSDateComponents* dateComponents = [[NSCalendar currentCalendar] 
                                        components:
                                        NSEraCalendarUnit |
                                        NSYearCalendarUnit |
                                        NSMonthCalendarUnit |
                                        NSDayCalendarUnit
                                        fromDate:date];
    [dateComponents setHour:[components hour]];
    [dateComponents setMinute:[components minute]];
    [dateComponents setSecond:[components second]];
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

-(OpeningHours*)hoursForDay:(NSDate*)day{
    NSDateComponents* components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:day];
    return [storeHours objectAtIndex:[components weekday]];
}

-(NSDate*)opensOnDay:(NSDate*)date{
    return [Location mergeComponents:[[self hoursForDay:date] opens] withDate:date];
}

-(NSDate*)closesOnDay:(NSDate*)date{
    NSDate* closes = [Location mergeComponents:[[self hoursForDay:date] closes] withDate:date];
    if([closes compare:[self opensOnDay:date]] == NSOrderedAscending){
        NSDate* nextDay = [[NSCalendar currentCalendar] dateByAddingComponents:oneDay 
                                                                        toDate:date 
                                                                       options:0];
        closes = [Location mergeComponents:[[self hoursForDay:date] closes] withDate:nextDay];
    }
    return closes;
}

-(NSDate*)opensToday{
    NSDate* now = [NSDate date];
    NSDate* yesterday = [[NSCalendar currentCalendar] dateByAddingComponents:minusOneDay 
                                                                      toDate:now 
                                                                     options:0];
    NSDate* yesterdayClose = [self closesOnDay:yesterday];
    if([yesterdayClose compare:now] == NSOrderedAscending){
        return [self opensOnDay:now];
    } else {
        return [self opensOnDay:yesterday];
    }
}

-(NSDate*)closesToday{
    NSDate* now = [NSDate date];
    NSDate* yesterday = [[NSCalendar currentCalendar] dateByAddingComponents:minusOneDay 
                                                                      toDate:now 
                                                                     options:0];
    NSDate* yesterdayClose = [self closesOnDay:yesterday];
    if([yesterdayClose compare:now] == NSOrderedAscending){
        return [self closesOnDay:now];
    } else {
        return yesterdayClose;
    }
}

-(StoreState)storeState{
    NSDate* now = [NSDate date];
    if([now compare:[self opensToday]] == NSOrderedAscending){
        return Closed;
    }
    NSDate* close = [self closesToday];
    if([now compare:close] == NSOrderedDescending){
        return Closed;
    }
    if([close timeIntervalSinceDate:now] < lastCall){
        return Closing;
    }
    return Open;
}

@end
