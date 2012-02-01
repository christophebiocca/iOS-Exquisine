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
#import "Menu.h"
#import "OrderCell.h"

@implementation FavoritesRenderer

-(FavoritesRenderer *)initWithOrderListAndMenu:(NSMutableArray *)anOrderList:(Menu *)aMenu
{
    theMenu = aMenu;
    favoriteOrders = anOrderList;
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([favoriteOrders count])
        return [favoriteOrders count];
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([favoriteOrders count])
    {
        OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:[OrderCell cellIdentifier]];        
        
        if (cell == nil) {
            cell = [[OrderCell alloc] init];
        }
        
        [cell setOrder:[favoriteOrders objectAtIndex:[indexPath row]]];
        
        return cell;
    }
    else
    {
        CellData *aCell = [[CellData alloc] init];
        [aCell setCellTitleFontSize:17];
        [aCell setCellDescFontSize:17];
        [aCell setCellTitleFontType:@"HelveticaNeue-Medium"];
        [aCell setCellDescFontType:@"HelveticaNeue"];
        aCell.cellTitle = @"You have not saved any favorites!";
        aCell.cellDesc = @"";
        
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        
        [aCell configureCell:cell];
        
        return cell;
    }
}

@end
