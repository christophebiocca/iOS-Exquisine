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

-(MenuComponent *)initFromMenuComponent:(MenuComponent *)aMenuComponent
{
    name = aMenuComponent.name;
    desc = aMenuComponent.desc;
    primaryKey = aMenuComponent.primaryKey;
    
    return self;
}

-(MenuComponent *)initFromData:(NSDictionary *)inputData
{
    name = [inputData objectForKey:@"name"];
    primaryKey = [[inputData objectForKey:@"pk"] intValue];
    desc = [inputData objectForKey:@"description"];
    
    return self;
}

- (MenuComponent *)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        name = [decoder decodeObjectForKey:@"name"];
        desc = [decoder decodeObjectForKey:@"desc"];
        primaryKey = [[decoder decodeObjectForKey:@"primary_key"]intValue];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Rinse and repeat this:
    [encoder encodeObject:name forKey:@"name"];
    [encoder encodeObject:desc forKey:@"desc"];
    [encoder encodeObject:[NSString stringWithFormat:@"%i", primaryKey] forKey:@"primary_key"];
}

@end
