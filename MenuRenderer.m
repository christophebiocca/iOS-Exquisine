//
//  MenuRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuRenderer.h"
#import "Menu.h"
#import "Item.h"
#import "MenuCell.h"
#import "ItemMenuCell.h"
#import "Combo.h"

@implementation MenuRenderer

-(MenuRenderer *)initWithMenu:(Menu *)aMenu
{
    self = [super init];
    
    if(self)
    {
        NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *sections = [[NSMutableArray alloc] initWithCapacity:0];
        
        if ([[aMenu submenuList] count] > 0)
        {
            [data addObject:[aMenu submenuList]];
            [sections addObject:@""];
        }
        
        if ([[aMenu comboList] count] > 0)
        {
            [data addObject:[aMenu comboList]];
            [sections addObject:@"Combos"];
        }
        
        listData = [NSArray arrayWithArray:data];
        sectionNames = [NSArray arrayWithArray:sections];
        context = CELL_CONTEXT_MENU;
        
    }
    
    return self;
}


@end
