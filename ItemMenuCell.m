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

-(void)setItem:(Item*)theItem
{
    
    item = theItem;
    [super setMenuComponent:theItem];
    
    UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
    UIFont *descFont = [UIFont fontWithName:@"HelveticaNeue" size:17];
    [[self textLabel] setFont:titleFont];
    [[self detailTextLabel] setFont:descFont];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
