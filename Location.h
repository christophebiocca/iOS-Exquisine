//
//  Location.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "AutomagicalCoder.h"

typedef enum StoreState 
{
    Open,
    Closing,
    Closed
} StoreState;

@interface Location : AutomagicalCoder<MKAnnotation, NSCopying, NSCoding>
{
    NSString* primaryKey;
    NSArray* storeHours;
    NSInteger lastCall;
    NSDecimalNumber *latitude;
    NSDecimalNumber *longitude;
    NSString *address;
}

-(id)initFromData:(NSDictionary*)inputData;

@property (retain,readonly) NSString *address;
@property (retain,readonly) NSString *primaryKey;

-(StoreState)storeState;
-(NSDate*)nextOpenAfterThisTime:(NSDate*)date;
-(NSDate*)nextClosedAfterThisTime:(NSDate*)date;
-(NSDate*)opensToday;
-(NSDate*)closesToday;
-(NSDate*)nextOpen;
-(NSDate*)nextClose;
-(NSString*)storeHourBlurb;
-(BOOL)wouldBeOpenAt:(NSDate*)thisTime;

@end
