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

-(void)apiCallCompleted:(APICall*)call;
-(void)apiCall:(APICall*)call returnedError:(NSError*)error;

@end
