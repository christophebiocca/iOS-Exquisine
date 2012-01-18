//
//  APICallDelegate.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class APICall;

@protocol APICallDelegate <NSObject>

-(void)apiCall:(APICall*)call completedWithData:(NSDictionary*)data;
-(void)apiCall:(APICall*)call returnedError:(NSError*)error;

@end
