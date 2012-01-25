//
//  FavoritesRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavoritesRenderer.h"
#import "Order.h"
#import "OrderRenderer.h"
#import "Utilities.h"
#import "CellData.h"

@implementation FavoritesRenderer


-(void) redraw
{
    [orderRenderList removeAllObjects];
    //This may actually result in two renderers being created for each item.
    //This may be a problem. We'll see.
    for (Order *currentOrder in favoriteOrders) {
        [orderRenderList addObject:[[OrderRenderer alloc] initWithOrder:currentOrder]];
    }
    
    [suffixList removeAllObjects];

    if([favoriteOrders count] == 0)
    {
        CellData *aCell = [[CellData alloc] init];
        aCell.cellTitle = @"No Favorites Selected";
        aCell.cellDesc = @"";
        [suffixList addObject:aCell];
    }
}

-(FavoritesRenderer *)initWithOrderList:(NSMutableArray *)anOrderList
{
    favoriteOrders = anOrderList;
    
    displayLists = [[NSMutableArray alloc] initWithCapacity:0];
    suffixList = [[NSMutableArray alloc] initWithCapacity:0];
    
    orderRenderList = [[NSMutableArray alloc] initWithCapacity:0];
    
    [displayLists addObject:orderRenderList];
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
