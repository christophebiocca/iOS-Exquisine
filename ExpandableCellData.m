//
//  ExpandableCellData.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExpandableCellData.h"

@implementation ExpandableCellData

@synthesize isOpen;
@synthesize primaryItem;
@synthesize expansionContents;
@synthesize renderer;

-(id)initWithPrimaryItem:(id)aThing AndRenderer:(ListRenderer *)aRenderer
{
    self = [super init];
    
    if (self)
    {
        renderer = aRenderer;
        primaryItem = aThing;
        isOpen = NO;
        expansionContents = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
