//
//  MenuRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuRenderer.h"
#import "Menu.h"
#import "ItemRenderer.h"
#import "Item.h"
#import "CellData.h"
#import "Utilities.h"

@implementation MenuRenderer

-(void) redraw
{
    [itemRenderList removeAllObjects];
    
    //We don't know whether these objects will be items, or submenus until we look at them.
    for (id currentThing in menuInfo.submenuList) {
        if( [currentThing isKindOfClass:[Item class]])
        {
            [itemRenderList addObject:[[ItemRenderer alloc] initWithItem:currentThing]];
        }
        if( [currentThing isKindOfClass:[Menu class]])
        {
            [itemRenderList addObject:[[MenuRenderer alloc] initWithMenu:currentThing]];
        }
    }
}

-(MenuRenderer *)initWithMenu:(Menu *)aMenu
{
    menuInfo = aMenu;
    displayLists = [[NSMutableArray alloc] initWithCapacity:0];
    suffixList = [[NSMutableArray alloc] initWithCapacity:0];
    
    itemRenderList = [[NSMutableArray alloc] initWithCapacity:0];
    
    [displayLists addObject:itemRenderList];
    [displayLists addObject:suffixList];
    
    [self redraw];
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int memberTally = 0;
    
    for (NSMutableArray *componentList in displayLists) {
        memberTally += [componentList count];
    }
    
    return memberTally;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    [[Utilities MemberOfCompositeListAtIndex:displayLists:[indexPath row]] configureCell:cell];
    
    return cell;
}


@end
