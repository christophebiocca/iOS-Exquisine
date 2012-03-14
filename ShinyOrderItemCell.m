//
//  ShinyOrderItemCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyOrderItemCell.h"
#import "Item.h"
#import "Utilities.h"

@implementation ShinyOrderItemCell

+(NSString *)cellIdentifier
{
    return @"ShinyOrderItemCell";
}

+(BOOL)canDisplayData:(id)data
{
    return [data isKindOfClass:[NSDictionary class]] && [data objectForKey:@"orderItem"] && [data objectForKey:@"index"];
}

-(void)setData:(id)data
{
    if ([[self class] canDisplayData:data]) {
        itemCellDict = data;
    }
    else
    {
        CLLog(LOG_LEVEL_ERROR, @"An improper data object was given to ShinyOrderItemCell's setData:");
    }
    [self updateCell];
}

-(void)updateCell
{

    if ([[itemCellDict objectForKey:@"index"] intValue] % 2) {
        [[self contentView] setBackgroundColor:[Utilities fravicDarkPinkColor]];
    }
    else
    {
        [[self contentView] setBackgroundColor:[Utilities fravicLightPinkColor]];
    }
    
    [[self textLabel] setText:[[itemCellDict objectForKey:@"orderItem"] name]];
    [[self textLabel] setFont:[Utilities fravicTextFont]];
    [[self detailTextLabel] setText:[Utilities FormatToPrice:[[itemCellDict objectForKey:@"orderItem"] price]]];
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

@end
