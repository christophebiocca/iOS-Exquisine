//
//  ItemGroupRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-01.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemGroupRenderer.h"
#import "Item.h"
#import "ItemGroup.h"

@implementation ItemGroupRenderer

-(ItemGroupRenderer *)initWithItemGroup:(ItemGroup *)anItemGroup
{
    self = [super init];
    
    listData = [NSMutableArray arrayWithObject:[anItemGroup listOfItems]];
    sectionNames = [[NSMutableArray alloc] initWithObjects:[anItemGroup name],nil];
    
    return self;
}

@end
