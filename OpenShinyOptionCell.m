//
//  OpenShinyOptionCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OpenShinyOptionCell.h"
#import "Option.h"

@implementation OpenShinyOptionCell

-(id)init
{
    self = [super init];
    if (self) {
        optionExpandedImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ExpandedMenuDropdown.png"]];
        [self addSubview:optionExpandedImage];
        
        optionNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(93, 27, 120, 21)];
        [optionNameLabel setFont:[Utilities fravicHeadingFont]];
        [optionNameLabel setTextAlignment:UITextAlignmentCenter];
        [optionNameLabel setTextColor:[Utilities fravicDarkRedColor]];
        [optionNameLabel setBackgroundColor:[UIColor clearColor]];
        [optionNameLabel setAdjustsFontSizeToFitWidth:YES];
        
        [self addSubview:optionNameLabel];
    }
    return self;
}

+(BOOL) canDisplayData:(id)data
{
    //Returns true iff the data passed in is meant to be displayed by this cell.
    return ([data isKindOfClass:[NSDictionary class]] && [data objectForKey:@"openOption"]);
}

+(NSString *) cellIdentifier
{
    //Must return a unique string identifier for this type of cell.
    return @"OpenShinyOptionCell";
}

-(void) setData:(id) data
{
    if (![[self class] canDisplayData:data])
    {
        CLLog(LOG_LEVEL_ERROR, @"An unsupported data type was sent to OpenShinyOptionCell's setData:");
        return;
    }

    theOption = [data objectForKey:@"openOption"];
    
    [self updateCell];
}

+(CGFloat) cellHeightForData:(id) data
{
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ExpandedMenuDropdown.png"]] frame].size.height;
}

-(void) updateCell
{
    [optionNameLabel setText:[theOption name]];
    //Any of the changed associated with the data input in setData should occur here.
    //If the data is prone to changing, this cell should call updateCell via an NSNotificationCenter.
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

@end
