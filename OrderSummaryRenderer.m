//
//  OrderSummaryRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderSummaryRenderer.h"
#import "Combo.h"
#import "ComboRenderer.h"
#import "Order.h"
#import "Item.h"
#import "ItemRenderer.h"
#import "Utilities.h"

@implementation OrderSummaryRenderer

-(OrderSummaryRenderer *)initWithOrder:(Order *)anOrder
{
    self = [super init];

    return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}

@end
