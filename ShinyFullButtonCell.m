//
//  ShinyFullButtonCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyFullButtonCell.h"

@implementation ShinyFullButtonCell

static float cellBorderSize = 10.0f;

+(BOOL) canDisplayData:(id)data
{
    //Returns true iff the data passed in is meant to be displayed by this cell.
    return ([data isKindOfClass:[UIButton class]]);
}

+(NSString *) cellIdentifier
{
    //Must return a unique string identifier for this type of cell.
    return @"FullButtonCell";
}

-(void) setData:(id) data
{
    if (![[self class] canDisplayData:data])
    {
        CLLog(LOG_LEVEL_ERROR, @"An unsupported data type was sent to FullButtonCell's setData:");
        return;
    }
    
    theButton = data;
    
    [self addSubview:theButton];

    [self updateCell];
}

+(CGFloat)cellHeightForData:(id)data
{
    return [data frame].size.height + 2 * cellBorderSize;
}

-(void) updateCell
{
    [theButton setFrame:CGRectMake((320 - [theButton frame].size.width)/2, 
                                  cellBorderSize, 
                                  [theButton frame].size.width, 
                                   [theButton frame].size.height)];
    
    //Any of the changed associated with the data input in setData should occur here.
    //If the data is prone to changing, this cell should call updateCell via an NSNotificationCenter.
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

@end