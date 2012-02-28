//
//  MenuCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuCell.h"
#import "Menu.h"
#import "Utilities.h"

@implementation MenuCell

+(NSString*)cellIdentifier{
    return @"MenuCell";
}

-(void)setData:(id)theMenu
{
    menu = theMenu;
    [super setData:theMenu];
    
    UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
    UIFont *descFont = [UIFont fontWithName:@"HelveticaNeue" size:17];
    
    [[self textLabel] setFont:titleFont];
    [[self detailTextLabel] setFont:descFont];
    
    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
}

-(void)updateCell
{
    [super updateCell];
    [[self detailTextLabel] setText:@""];
    [self setNeedsDisplay];
}

@end
