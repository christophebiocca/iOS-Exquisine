//
//  OrderRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Utilities.h"
#import "OrderRenderer.h"
#import "GeneralPurposeViewCell.h"
#import "GeneralPurposeViewCellData.h"
#import "Menu.h"
#import "Order.h"
#import "Item.h"
#import "Combo.h"
#import "OrderManager.h"

@implementation OrderRenderer


-(OrderRenderer *)initWithOrderManager:(OrderManager *)anOrderManager
{
    
    self = [super init];
    
    if(self)
    {
        orderManager = anOrderManager;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderChanged:) name:ORDER_MANAGER_NEEDS_REDRAW object:orderManager];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *sections = [[NSMutableArray alloc] initWithCapacity:0];
        
        [sections addObject:@"Your Order"];
        //orderChanged: will deal with populating this section.
        [data addObject:[NSMutableArray arrayWithCapacity:0]];
        
        if ([[[anOrderManager thisMenu] submenuList] count] > 0)
        {
            [data addObject:[[anOrderManager thisMenu] submenuList]];
            [sections addObject:@"Menu"];
        }
        
        if ([[[anOrderManager thisMenu] comboList] count] > 0)
        {
            [data addObject:[[anOrderManager thisMenu] comboList]];
            [sections addObject:@"Combos"];
        }
        
        listData = [NSMutableArray arrayWithArray:data];
        sectionNames = [NSMutableArray arrayWithArray:sections];
        
        [self orderChanged:nil];
    }
    
    return self;
}

-(void) orderChanged:(NSNotification *)aNotification
{
    NSMutableArray *itemSection = [[NSMutableArray alloc] initWithCapacity:0];
    for (Combo* aCombo in [[orderManager thisOrder] comboList]) {
        [itemSection addObjectsFromArray:[aCombo prepareDisplayList]];
    }
    for (Item* anItem in [[orderManager thisOrder] itemList]) {
        [itemSection addObject:anItem];
    }
    
    if([itemSection count] > 0)
        [listData replaceObjectAtIndex:0 withObject:itemSection];
    else
    {
        GeneralPurposeViewCellData *cellData = [[GeneralPurposeViewCellData alloc] init];
        [cellData setTitle:@"You have not selected any Items"];
        [cellData setTitleFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:13]];
        [listData replaceObjectAtIndex:0 withObject:[NSArray arrayWithObject:cellData]];
    }
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) 
    {
        //first we check if it's an item:
        id cellObject = [self objectForCellAtIndex:indexPath];
        //Then see if it's an item:
        if ([cellObject isKindOfClass:[Item class]])
        {
            [[orderManager thisOrder] removeItem:cellObject];
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else if([cellObject isKindOfClass:[Combo class]]){
            [[orderManager thisOrder] removeCombo:cellObject];
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
        }else if([cellObject isKindOfClass:[NSDictionary class]]){
            [[orderManager thisOrder] removeItem:[cellObject objectForKey:@"data"]];
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
        if([[listData objectAtIndex:0] count] == 0)
            [tableView setEditing:NO animated:YES];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        //do more stuff
    }
    else if (editingStyle == UITableViewCellEditingStyleNone)
    {
        //do more more stuff
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //To assess whether we can edit the row, we grab the cell renderer:
    id cellObject = [self objectForCellAtIndex:indexPath];
    //Then see if it's an item:
    if ([cellObject isKindOfClass:[Item class]] ||
        [cellObject isKindOfClass:[Combo class]]||
        [cellObject isKindOfClass:[NSDictionary class]])
    {
        //if so,  we can edit it.
        return YES;
    }
    return NO;
}

@end
