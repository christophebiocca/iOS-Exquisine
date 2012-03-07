//
//  Utilities.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* ITEM_GROUP_MODIFIED;

typedef enum LogLevel {
    LOG_LEVEL_ERROR = 0,
    LOG_LEVEL_WARNING = 1,
    LOG_LEVEL_INFO = 2,
    LOG_LEVEL_DEBUG = 3,
} LogLevel;

@interface Utilities : NSObject

+(NSString *)FormatToPrice:(NSDecimalNumber*) price;

+(NSString *)FormatToDate:(NSDate *)theDate;

+(NSInteger)CompositeListCount:(NSMutableArray *) compositeList;

+(id)MemberOfCompositeListAtIndex:(NSMutableArray *)compositeList:(NSInteger) anInt;

+(void)logLevel:(LogLevel)level message:(NSString*)message;

+(NSString*)uuid;

@end
