//
//  GetMenu.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GetMenu.h"
#import "APICallProtectedMethods.h"
#import "Menu.h"

@implementation GetMenu

@synthesize menu;

+(void)getMenu:(void(^)(id))success failure:(void(^)(id,NSError*))failure{
    [self sendGETRequestForLocation:@"/customer/menu/1/" 
                            success:success
                            failure:failure];
}

-(void)postCompletionHook{
    [super postCompletionHook];
    if(![self error]){
        menu = [[Menu alloc] initFromData:[self jsonData]];
    }
}

@end
