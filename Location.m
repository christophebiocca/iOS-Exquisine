//
//  Location.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Location.h"

@implementation Location

@synthesize primaryKey;

-(id)initFromData:(NSDictionary*)inputData{
    if(self = [super init]){
        primaryKey = [inputData objectForKey:@"pk"];
    }
    return self;
}

@end
