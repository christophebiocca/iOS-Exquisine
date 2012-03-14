//
//  ShinyOrderComboCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyOrderComboCell.h"
#import "Combo.h"

@implementation ShinyOrderComboCell

+(NSString *)cellIdentifier
{
    return @"ShinyOrderComboCell";
}

+(BOOL)canDisplayData:(id)data
{
    return [data isKindOfClass:[NSDictionary class]] && [data objectForKey:@"combo"] && [data objectForKey:@"index"];
}

-(void)setData:(id)data
{
    if([[self class] canDisplayData:data])
    {
        comboCellDict = data;
    }
    else
    {
        CLLog(LOG_LEVEL_ERROR, @"An improper data object was given to ShinyOrderComboCell's setData:");
    }
    [self updateCell];
}

-(void)updateCell
{
    
    if ([[comboCellDict objectForKey:@"index"] intValue] % 2) {
        [[self contentView] setBackgroundColor:[Utilities fravicDarkPinkColor]];
        [[self contentView] setBackgroundColor:[Utilities fravicLightPinkColor]];
    }
    else
    {
        [[self contentView] setBackgroundColor:[Utilities fravicLightPinkColor]];
    }
    
    [[self textLabel] setText:[[comboCellDict objectForKey:@"combo"] name]];
    [[self detailTextLabel] setText:[Utilities FormatToPrice:[[comboCellDict objectForKey:@"item"] price]]];
    [[self textLabel] setFont:[Utilities fravicTextFont]];
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}
@end
