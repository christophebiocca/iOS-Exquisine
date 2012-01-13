//
//  CellInfo.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellInfo : NSObject{

    NSString *labelText;
    NSString *descriptionText;
    BOOL hasSwitch;
    BOOL switchState;

}

@property BOOL hasSwitch;
@property BOOL switchState;
@property (retain) NSString *labelText;
@property (retain) NSString *descriptionText;

@end
