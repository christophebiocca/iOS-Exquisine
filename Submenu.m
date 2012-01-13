//
//  Submenu.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Submenu.h"
#import "Item.h"

@implementation Submenu

@synthesize name;
@synthesize itemList;

-(void) addItem:(Item *)anItem{
    [itemList addObject:anItem];
}


@end
