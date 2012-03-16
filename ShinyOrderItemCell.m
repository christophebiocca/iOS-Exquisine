//
//  ShinyOrderItemCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyOrderItemCell.h"
#import "Item.h"
#import "NSMutableNumber.h"
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

-(id)init
{
    self = [super init];
    if (self) {
        
        numberOfItemsLabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                            240, 
                                            1, 
                                            30, 
                                            21)];
        
        [numberOfItemsLabel setFont:[UIFont fontWithName:@"AmericanTypewriter-Bold" size:13]];
        [numberOfItemsLabel setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:numberOfItemsLabel];
        
    }
    return self;
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
    [[self textLabel] setFont:[UIFont fontWithName:@"AmericanTypewriter" size:14]];
    [[self detailTextLabel] setText:[Utilities FormatToPrice:[[itemCellDict objectForKey:@"orderItem"] price]]];
    
    [numberOfItemsLabel setText:[NSString stringWithFormat:@"x%@", [(Item *)[itemCellDict objectForKey:@"orderItem"] numberOfItems]]];
    
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
