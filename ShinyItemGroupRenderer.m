//
//  ShinyItemGroupRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyItemGroupRenderer.h"
#import "ExpandableCellData.h"
#import "MenuSectionHeaderView.h"
#import "ItemGroup.h"
#import "Menu.h"

@implementation ShinyItemGroupRenderer


-(id)initWithItemGroup:(ItemGroup *)anItemGroup
{
    self = [super init];
    
    if(self)
    {
        theItemGroup = anItemGroup;
        
        sectionNames = [[NSMutableArray alloc] init];
        listData = [[NSMutableArray alloc] init];
        
        [sectionNames addObject:@"Menus"];
        NSMutableArray *menuSectionContents = [[NSMutableArray alloc] init];
        
        [menuSectionContents addObject:[MenuSectionHeaderView new]];
        
        for (Menu *eachMenu in [theItemGroup satisfyingMenus]) {
            if ([[eachMenu submenuList] count] > 0) {
                [menuSectionContents addObject:[[ExpandableCellData alloc]initWithPrimaryItem:eachMenu AndRenderer:self]];
            }
        }
        
        [listData addObject:menuSectionContents];
    }
    
    return self;
}


@end
