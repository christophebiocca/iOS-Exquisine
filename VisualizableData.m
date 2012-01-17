//
//  VisualizableData.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VisualizableData.h"

@implementation VisualizableData

@synthesize dataOwner;

-(id)initWithOwner:(id)owner{
    if((self = [super init])){
        dataOwner = owner;
    }
    return self;
}

@end
