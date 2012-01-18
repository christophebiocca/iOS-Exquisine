//
//  CellData.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CellData.h"

@implementation CellData

@synthesize cellTitle;
@synthesize cellDesc;
@synthesize cellSwitchState;

-(UITableViewCell *)configureCell: (UITableViewCell *) newCell
{
    [[newCell textLabel] setText:cellTitle];
    [[newCell detailTextLabel] setText:cellDesc];
    
    if (cellSwitchState)
    {
        [newCell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else
    {
        [newCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    return newCell;
}

@end
