//
//  OrderTabViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderTabViewController.h"
#import "OrderManager.h"
#import "ShinyOrderTabRenderer.h"
#import "OrderSectionHeaderView.h"
#import "OrderSectionFooterView.h"
#import "MenuSectionHeaderView.h"
#import "OrderTabView.h"

@implementation OrderTabViewController

-(id)initWithOrderManager:(OrderManager *)anOrderManager
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        theOrderManager = anOrderManager;
        orderView = [[OrderTabView alloc] init];
        orderRenderer = [[ShinyOrderTabRenderer alloc] initWithOrderManager:theOrderManager];
        [[orderView orderTable] setDelegate:self];
        [[orderView orderTable] setDataSource:orderRenderer];
    }
    return self;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CustomViewCell cellHeightForData:[orderRenderer objectForCellAtIndex:indexPath]];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)loadView
{
    [super loadView];
    [self setView:orderView];
}

@end
