//
//  ViewCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewCell.h"

@implementation ViewCell

+(BOOL) canDisplayData:(id)data
{
    //Returns true iff the data passed in is meant to be displayed by this cell.
    
    if ([data isKindOfClass:[UIButton class]]) {
        return NO;
    }
    
    return [data isKindOfClass:[UIView class]];
    
}

+(NSString *) cellIdentifier
{
    //Must return a unique string identifier for this type of cell.
    return @"ViewCell";
}



-(void) setData:(id) data
{
    if (![[self class] canDisplayData:data])
    {
        CLLog(LOG_LEVEL_ERROR, @"An unsupported data type was sent to ViewCell's setData:");
        return;
    }
    
    if (internalView) {
        [internalView removeFromSuperview];
    }
    internalView = data;
    [self addSubview:internalView];
    
    [self updateCell];
}

-(void) updateCell
{
    //Any of the changed associated with the data input in setData should occur here.
    
    //If the data is prone to changing, this cell should call updateCell via an NSNotificationCenter.
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

+(CGFloat)cellHeightForData:(id)data
{
    return [data frame].size.height;
}

@end
