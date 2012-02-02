//
//  Location.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

typedef enum StoreState {
    Open,
    Closing,
    Closed
} StoreState;

@interface Location : NSObject{
    NSString* primaryKey;
    NSArray* storeHours;
    NSInteger lastCall;
}

-(id)initFromData:(NSDictionary*)inputData;

@property(retain,readonly)NSString* primaryKey;

-(StoreState)storeState;
-(NSDate*)opensOnDay:(NSDate*)date;
-(NSDate*)closesOnDay:(NSDate*)date;
-(NSDate*)opensToday;
-(NSDate*)closesToday;
-(NSDate*)nextOpen;
-(NSDate*)nextClose;

@end
