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

+(void)getMenuForRestaurant:(NSInteger)restaurant success:(void (^)(id))success failure:(void (^)(id, NSError *))failure{
    [self sendGETRequestForLocation:[NSString stringWithFormat:@"/customer/menu/%d/", restaurant]
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
