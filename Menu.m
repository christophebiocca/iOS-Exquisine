//
//  Menu.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Menu.h"
#import "Submenu.h"


@implementation Menu

@synthesize resterauntName;
@synthesize submenuList;

-(void)addSubmenu:(Submenu *)aSubmenu{
    [submenuList addObject:aSubmenu];
}

@end
