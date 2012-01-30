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
@synthesize cellTitleFontSize;
@synthesize cellDescFontSize;
@synthesize cellDescFontType;
@synthesize cellTitleFontType;
@synthesize notSelectable;


-(CellData *)init
{
    self = [super init];
    
    cellTitle = @"DefaultCellTitle";
    cellDesc = @"DefaultCellDesc";
    cellSwitchState = NO;
    cellColour = [UIColor whiteColor];
    cellAccessory = @"";
    cellStyle = UITableViewCellStyleValue1;
    cellTabbing = 0;
    cellTitleFontSize = 17;
    cellTitleFontType = @"Helvetica-Bold";
    cellDescFontSize = 17;
    cellDescFontType = @"Helvetica";
    notSelectable = YES;
    return self;
}

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
        [newCell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    [newCell setBackgroundColor:cellColour];
    [newCell setOpaque:YES];
    
    [newCell setIndentationWidth:30.0f];
    [newCell setIndentationLevel:cellTabbing];
    
    UIFont *titleFont = [UIFont fontWithName:cellTitleFontType size:cellTitleFontSize];
    UIFont *descFont = [UIFont fontWithName:cellDescFontType size:cellDescFontSize];
    
    [[newCell textLabel] setFont:titleFont];
    [[newCell detailTextLabel] setFont:descFont];
    
    if(notSelectable)
        [newCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
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

-(void)tab
{
    cellTabbing++;
}

@end
