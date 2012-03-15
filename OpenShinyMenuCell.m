//
//  OpenShinyMenuCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OpenShinyMenuCell.h"
#import "Menu.h"

@implementation OpenShinyMenuCell

-(id)init
{
    self = [super init];
    if (self) {
        menuExpandedImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ExpandedMenuDropdown.png"]];
        [self addSubview:menuExpandedImage];
        
        menuNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(93, 27, 120, 21)];
        [menuNameLabel setFont:[Utilities fravicHeadingFont]];
        [menuNameLabel setTextAlignment:UITextAlignmentCenter];
        [menuNameLabel setTextColor:[Utilities fravicDarkRedColor]];
        [menuNameLabel setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:menuNameLabel];
    }
    return self;
}

+(BOOL) canDisplayData:(id)data
{
    //Returns true iff the data passed in is meant to be displayed by this cell.
    return [data isKindOfClass:[NSDictionary class]] && [data objectForKey:@"openMenu"];
}

+(NSString *) cellIdentifier
{
    //Must return a unique string identifier for this type of cell.
    return @"OpenShinyMenuCell";
}

-(void) setData:(id) data
{
    if (![[self class] canDisplayData:data])
    {
        CLLog(LOG_LEVEL_ERROR, @"An unsupported data type was sent to OpenShinyMenuCell's setData:");
        return;
    }
    theMenu = [data objectForKey:@"openMenu"];

    [self updateCell];
}

+(CGFloat) cellHeightForData:(id) data
{
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ExpandedMenuDropdown.png"]] frame].size.height;
}

-(void) updateCell
{
    [menuNameLabel setText:[theMenu name]];
    //Any of the changed associated with the data input in setData should occur here.
    //If the data is prone to changing, this cell should call updateCell via an NSNotificationCenter.
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

@end
