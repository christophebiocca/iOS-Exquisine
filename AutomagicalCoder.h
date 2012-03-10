//
//  AutomagicalCoder.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-08.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

typedef enum Version {
    VERSION_0_0_0 = 0,
    VERSION_1_0_0 = 1,
    VERSION_1_0_1 = 2,
    VERSION_1_1_0 = 3,
} Version;

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface AutomagicalCoder : NSObject <NSCoding>
{
    Version harddiskDataVersion;
}

@end
