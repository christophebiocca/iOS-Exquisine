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
@synthesize cellColour;
@synthesize cellAccessory;
@synthesize cellStyle;

-(CellData *)init
{
    self = [super init];
    
    cellTitle = @"DefaultCellTitle";
    cellDesc = @"DefaultCellDesc";
    cellSwitchState = NO;
    cellColour = [UIColor clearColor];
    cellAccessory = @"";
    cellStyle = UITableViewCellStyleValue1;
    
    return self;
}

-(UITableViewCell *)configureCell: (UITableViewCell *) newCell
{
    newCell = [newCell initWithStyle:cellStyle reuseIdentifier:@"cell"];
    
    [[newCell textLabel] setText:cellTitle];
    [[newCell detailTextLabel] setText:cellDesc];
    
    if (cellSwitchState)
    {
        [newCell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else
    {
        [newCell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    [newCell setBackgroundColor:cellColour];
    [newCell setOpaque:YES];
    
    //This doesn't actually work. It's not mission critical, so I'll come back to it.
    /*
    if(cellAccessory == @"plus")
    {
        UIBarButtonItem *plusButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil];
        
        [newCell addSubview:[plusButton customView]];
    }
    */
    
    return newCell;
}

@end
