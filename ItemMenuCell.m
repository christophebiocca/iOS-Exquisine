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

-(void)setData:(id)theItem
{
    
    item = theItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCell) name:ITEM_MODIFIED object:theItem];
    
    [super setData:theItem];
    
    [self updateCell];
}

-(void)updateCell
{
    [super updateCell];
    
    [[self detailTextLabel] setText:[Utilities FormatToPrice:[item price]]];
    
    [self setNeedsDisplay];
}

@end
