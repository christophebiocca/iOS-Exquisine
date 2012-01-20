//
//  APICall.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponentView.h"

@protocol APICallDelegate;

@interface APICall : MenuComponentView{
    BOOL completed;
    NSError* error;
    NSDictionary* returnValue;
    id<APICallDelegate> delegate;
}

@property(readonly, retain)id<APICallDelegate>delegate;

-(void)setDelegate:(id<APICallDelegate>)delegate;
-(id)initGETRequestForLocation:(NSString*)location;
-(id)initPOSTRequestForLocation:(NSString*)location andJSONData:(NSDictionary*)jsonData;

@end
