//
//  IntegerInputCellData.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSMutableNumber;

@interface IntegerInputCellData : NSObject
{
    NSMutableNumber *number;
    NSNumber *lowerBound;
    NSNumber *upperBound;
}

@property (retain) NSMutableNumber *number;
@property (retain) NSNumber *lowerBound;
@property (retain) NSNumber *upperBound;

-(void) plus;
-(void) minus;

@end
