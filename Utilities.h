//
//  Utilities.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

+(NSString *)FormatToPrice:(NSDecimalNumber*) price;

+(NSInteger)CompositeListCount:(NSMutableArray *) compositeList;

+(id)MemberOfCompositeListAtIndex:(NSMutableArray *)compositeList:(NSInteger) anInt;

@end
