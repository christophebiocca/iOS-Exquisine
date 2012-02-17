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
    
    menuInfo = aMenu;
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ([[menuInfo submenuList] count] + [[menuInfo comboList] count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray *displayList = [[NSMutableArray alloc] initWithArray:[menuInfo submenuList]];
    
    [displayList addObjectsFromArray:[menuInfo comboList]];
    
    id thingToDisplay = [displayList objectAtIndex:[indexPath row]];
    
    MenuCompositeCell *cell = [tableView dequeueReusableCellWithIdentifier:[MenuCompositeCell cellIdentifierForMenuComponent:thingToDisplay AndContext:VIEW_CELL_CONTEXT_MENU]];
    
    if (cell == nil)
    {
        cell = [MenuCompositeCell customViewCellWithMenuComponent:thingToDisplay AndContext:VIEW_CELL_CONTEXT_MENU];
    }
    else
    {
        [cell setMenuComponent:thingToDisplay];
    }
    
    [cell setStyle:CELL_STYLE_PLAIN];
    
    return cell;
}


@end
