//
//  MenuComponent.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponent.h"
#import "TableData.h"
#import "CellData.h"

@implementation MenuComponent

@synthesize name,desc;
@synthesize primaryKey;

-(MenuComponent *)initFromData:(NSData *)inputData
{
    name = [inputData valueForKey:@"name"];
    primaryKey = [[inputData valueForKey:@"pk"] intValue];
    
    return self;
}

@end
