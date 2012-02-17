//
//  ItemMenuCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemMenuCell.h"
#import "Item.h"
#import "Utilities.h"

@implementation ItemMenuCell

+(NSString*)cellIdentifier{
    return @"ItemMenuCell";
}

-(void)setMenuComponent:(Item *)theItem
{
    
    item = theItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCell) name:ITEM_MODIFIED object:theItem];
    
    [super setMenuComponent:theItem];
    
    UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
    UIFont *descFont = [UIFont fontWithName:@"HelveticaNeue" size:17];
    [[self textLabel] setFont:titleFont];
    [[self detailTextLabel] setFont:descFont];
    
    [self updateCell];
}

-(void)updateCell
{
    [super updateCell];
    
    [[self detailTextLabel] setText:[Utilities FormatToPrice:[item price]]];
    
    [self setNeedsDisplay];
}

@end
