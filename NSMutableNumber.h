//
//  NSMutableNumber.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *NUMBER_MODIFIED;

@interface NSMutableNumber : NSObject <NSCoding>
{
    NSNumber *theNumber;
}

-(id)initWithNumber:(NSNumber *) aNumber;

-(void) addNumber:(NSNumber *) aNumber;

-(int) intValue;

@end
