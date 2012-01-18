//
//  GetMenu.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GetMenu.h"

@implementation GetMenu

-(id)init{
    NSString* location = @"customer/menu/3/";
    return self = [super initGETRequestForLocation:location];
}

@end
