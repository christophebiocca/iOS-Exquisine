//
//  PotentialPromoCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PotentialPromoCell.h"

@implementation PotentialPromoCell

-(id)init
{
    self = [super init];
    
    if (self) {
        cellImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ItemGroupSatisfied.png"]];
        
        [self addSubview:cellImage];
        
        settingsLabel = [[UILabel alloc] initWithFrame:CGRectMake(92, 21, 120, 21)];
        [settingsLabel setFont:[Utilities fravicHeadingFont]];
        [settingsLabel setTextAlignment:UITextAlignmentCenter];
        [settingsLabel setTextColor:[UIColor blackColor]];
        [settingsLabel setBackgroundColor:[UIColor clearColor]];
        [settingsLabel setAdjustsFontSizeToFitWidth:YES];
        
        [self addSubview:cellImage];
        [self addSubview:settingsLabel];
    }
    
    return self;
}

+(BOOL) canDisplayData:(id)data
{
    //Returns true iff the data passed in is meant to be displayed by this cell.
    return ([data isKindOfClass:[NSDictionary class]] && [data valueForKey:@"settingTitle"]);
}

+(NSString *) cellIdentifier
{
    //Must return a unique string identifier for this type of cell.
    return @"ShinySettingsCell";
}

-(void) setData:(id) data
{
    if (![[self class] canDisplayData:data])
    {
        CLLog(LOG_LEVEL_ERROR, @"An unsupported data type was sent to ShinySettingsCell's setData:");
        return;
    }
    
    settingsInfo = data;
    
    [self updateCell];
}

+(CGFloat)cellHeightForData:(id)data
{
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ItemGroupSatisfied.png"]] frame].size.height;
}

-(void) updateCell
{
    [settingsLabel setText:[settingsInfo valueForKey:@"settingTitle"]];
    //Any of the changed associated with the data input in setData should occur here.
    //If the data is prone to changing, this cell should call updateCell via an NSNotificationCenter.
    [self setNeedsLayout];
    [self setNeedsDisplay];
}



@end
