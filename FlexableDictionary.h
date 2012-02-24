//
//  FlexableDictionary.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlexableDictionary : NSObject
{
    NSMutableArray *info;
}

-(void) setAssociativeTuple:(id)objectOne:(id)objectTwo;

-(id) objectForKey:(id)key;

@end
