//
//  ShinyComboOrderItemCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyComboOrderItemCell.h"
#import "Item.h"

@implementation ShinyComboOrderItemCell

+(NSString *)cellIdentifier
{
    return @"ShinyComboOrderItemCell";
}

+(BOOL)canDisplayData:(id)data
{
    return [data isKindOfClass:[NSDictionary class]] && [data objectForKey:@"orderComboItem"] && [data objectForKey:@"index"];
}

-(void)setData:(id)data
{
    if ([[self class] canDisplayData:data]) {
        itemCellDict = data;
    }
    else
    {
        CLLog(LOG_LEVEL_ERROR, @"An improper data object was given to ShinyComboOrderItemCell's setData:");
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
    
    [[self textLabel] setText:[[itemCellDict objectForKey:@"orderComboItem"] name]];
    [[self textLabel] setFont:[Utilities fravicTextFont]];
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

@end
