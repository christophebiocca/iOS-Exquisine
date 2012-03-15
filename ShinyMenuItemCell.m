//
//  ShinyMenuItemCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyMenuItemCell.h"

@implementation ShinyMenuItemCell

+(BOOL) canDisplayData:(id)data
{
    //Returns true iff the data passed in is meant to be displayed by this cell.
    return [data isKindOfClass:[NSDictionary class]] && [data objectForKey:@"menuItem"];
}

+(NSString *) cellIdentifier
{
    //Must return a unique string identifier for this type of cell.
    return @"ShinyMenuItemCell";
}

-(void) setData:(id) data
{
    if (![[self class] canDisplayData:data])
    {
        CLLog(LOG_LEVEL_ERROR, @"An unsupported data type was sent to ShinyMenuItemCell's setData:");
        return;
    }

    [self updateCell];
}

+(CGFloat)cellHeightForData:(id)data
{
    return 22.0f;
}

-(void) updateCell
{
    //Any of the changed associated with the data input in setData should occur here.
    //If the data is prone to changing, this cell should call updateCell via an NSNotificationCenter.
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

@end
