//
//  ShinyChoiceCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyChoiceCell.h"
#import "Choice.h"

@implementation ShinyChoiceCell

+(BOOL) canDisplayData:(id)data
{
    //Returns true iff the data passed in is meant to be displayed by this cell.
    return ([data isKindOfClass:[NSDictionary class]] && [data objectForKey:@"choice"]);
}

+(NSString *) cellIdentifier
{
    //Must return a unique string identifier for this type of cell.
    return @"ShinyChoiceCell";
}

-(void) setData:(id) data
{
    if (![[self class] canDisplayData:data])
    {
        CLLog(LOG_LEVEL_ERROR, @"An unsupported data type was sent to ShinyChoiceCell's setData:");
        return;
    }

    theChoice = [data objectForKey:@"choice"];
    
    [self updateCell];
}

+(CGFloat) cellHeightForData:(id) data
{
    return 44.0f;
}

-(void) updateCell
{
    [[self textLabel] setText:[theChoice name]];
    //Any of the changed associated with the data input in setData should occur here.
    //If the data is prone to changing, this cell should call updateCell via an NSNotificationCenter.
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

@end
