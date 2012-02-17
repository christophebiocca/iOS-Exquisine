//
//  ItemGroupCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-31.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemGroupCell.h"
#import "ItemGroup.h"

@implementation ItemGroupCell


+(NSString *)cellIdentifier{
    return @"ItemGroupCell";
}

-(void)setMenuComponent:(ItemGroup *)theItemGroup
{   
    
    itemGroup = theItemGroup;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCell) name:ITEM_GROUP_MODIFIED object:theItemGroup];
    [super setMenuComponent:theItemGroup];
    
    [self updateCell];
}

-(void)updateCell
{
    [super updateCell];
    
    [[self detailTextLabel] setText:@""];
    
    if([itemGroup satisfied])
    {
        [self setAccessoryType:UITableViewCellAccessoryCheckmark];
        [self setBackgroundColor:[UIColor colorWithRed:0.83f green:1.0f blue:0.83f alpha:1.0f]];
    }
    else
    {
        [self setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
        [self setBackgroundColor:[UIColor colorWithRed:1.0f green:0.83f blue:0.83f alpha:1.0f]];
    }
    
    [self setNeedsDisplay];
}

@end
