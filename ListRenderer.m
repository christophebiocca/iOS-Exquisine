//
//  Renderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListRenderer.h"
#import "CustomViewCell.h"

@implementation ListRenderer

@synthesize listData;
@synthesize sectionNames;

-(id)init
{
    self = [super init];
    
    if (self) {
        listData = [[NSMutableArray alloc] init];
        sectionNames = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [listData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[listData objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cellData = [[listData objectAtIndex:[indexPath section]]objectAtIndex:[indexPath row]];
    
    CustomViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CustomViewCell cellIdentifierForData:cellData]];
    
    if (cell == nil) {
        cell = [CustomViewCell customViewCellFromData:cellData];
    }
    else
    {
        [cell setData:cellData];
    }
    
    return cell;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sectionNames objectAtIndex:section];
}

-(id)objectForCellAtIndex:(NSIndexPath *)index
{
    return [[listData objectAtIndex:[index section]] objectAtIndex:[index row]];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
