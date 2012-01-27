//
//  GetMenu.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JSONAPICall.h"

@class Menu;

@interface GetMenu : JSONAPICall {
    Menu* menu;
}

+(void)getMenuForRestaurant:(NSInteger)restaurant success:(void(^)(id))success failure:(void(^)(id,NSError*))failure;

@property(retain,readonly)Menu* menu;

@end
