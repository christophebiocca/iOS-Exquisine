//
//  MenuComponent.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponent.h"
#import "TableData.h"
#import "CellData.h"

@implementation MenuComponent

@synthesize tableData, cellData;



-(MenuComponent *)initWithNavigationController:(UINavigationController *)aController
{
    controller = aController;
    
    //By default these set up defaultish data into the cell and table
    //so that it will be immediately obvious if the child class forgot to override these.
    [self initializeCellData];
    [self initializeTableData];
    
    return self;
}

-(void) initializeCellData
{
    cellData = [[CellData alloc] initWithOwner:self];
    [cellData setCellTitle:@"Default"];
    [cellData setCellDesc:@"Dont forget to initialize!"];
}

-(void) initializeTableData
{
    tableData = [[TableData alloc] initWithOwner:self];
    [tableData setTableName:@"Default Table"];
}

//Because we've broken the contract with cellForRowAtIndex that ensures that the members
//of cellDataList are of type CellData, it's up to us to rectify it.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    [[[[tableData cellDataList] objectAtIndex:[indexPath row]] cellData] configureUITableViewCell:cell];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    //By default, if we there is an associated tableData, push it.
    //Note that the associated cells of a MenuComponent, must themselves be menu components!
    if (![[[[tableData cellDataList] objectAtIndex:[indexPath row]] tableData] isEqual:nil])
    {
        [controller pushViewController:[[[tableData cellDataList] objectAtIndex:[indexPath row]] tableData] animated:YES];
    }
}

@end
