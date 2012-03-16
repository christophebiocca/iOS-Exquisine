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

-(id)init
{
    self = [super init];
    if (self) {
        
        numberOfCombosLabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                       240, 
                                                                       1, 
                                                                       30, 
                                                                       21)];
        
        [numberOfCombosLabel setFont:[UIFont fontWithName:@"AmericanTypewriter-Bold" size:13]];
        [numberOfCombosLabel setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:numberOfCombosLabel];
        
    }
    return self;
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
    
    [numberOfCombosLabel setText:[NSString stringWithFormat:@"x%@", [(Combo *)[comboCellDict objectForKey:@"combo"] numberOfCombos]]];
    
    [[self textLabel] setText:[[comboCellDict objectForKey:@"combo"] name]];
    [[self detailTextLabel] setText:[Utilities FormatToPrice:[[comboCellDict objectForKey:@"combo"] price]]];
    [[self textLabel] setFont:[UIFont fontWithName:@"AmericanTypewriter" size:14]];
    
    [[self textLabel] setBackgroundColor:[UIColor clearColor]];
    [[self detailTextLabel] setBackgroundColor:[UIColor clearColor]];
    [[self detailTextLabel] setFont:[UIFont fontWithName:@"AmericanTypewriter" size:14]];
    [[self detailTextLabel] setTextColor:[UIColor blackColor]];
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

+(CGFloat)cellHeightForData:(id)data
{
    return 22.0f;
}
@end
