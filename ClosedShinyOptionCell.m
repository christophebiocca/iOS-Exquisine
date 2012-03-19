//
//  ClosedShinyOptionCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ClosedShinyOptionCell.h"
#import "Option.h"

@implementation ClosedShinyOptionCell

-(id)init
{
    self = [super init];
    
    if (self) {
        menuColapsedImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ColapsedMenuDropdown.png"]];
        
        [self addSubview:menuColapsedImage];
        
        menuNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(93, 26, 120, 21)];
        [menuNameLabel setFont:[Utilities fravicHeadingFont]];
        [menuNameLabel setTextAlignment:UITextAlignmentCenter];
        [menuNameLabel setTextColor:[UIColor blackColor]];
        [menuNameLabel setBackgroundColor:[UIColor clearColor]];
        numberOfItemsLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 50, 100, 21)];
        [numberOfItemsLabel setFont:[Utilities fravicTextFont]];
        [numberOfItemsLabel setTextColor:[Utilities fravicDarkRedColor]];
        [numberOfItemsLabel setBackgroundColor:[UIColor clearColor]];
        [numberOfItemsLabel setTextAlignment:UITextAlignmentRight];
        
        [self addSubview:menuNameLabel];
        [self addSubview:numberOfItemsLabel];
    }
    
    return self;
}

+(BOOL) canDisplayData:(id)data
{
    //Returns true iff the data passed in is meant to be displayed by this cell.
    return [data isKindOfClass:[NSDictionary class]] && [data objectForKey:@"closedOption"];
}

+(NSString *) cellIdentifier
{
    //Must return a unique string identifier for this type of cell.
    return @"ClosedShinyOptionCell";
}

-(void) setData:(id) data
{
    if (![[self class] canDisplayData:data])
    {
        CLLog(LOG_LEVEL_ERROR, @"An unsupported data type was sent to ClosedShinyOptionCell's setData:");
        return;
    }

    theOption = [data objectForKey:@"closedOption"];
    [self updateCell];
}

+(CGFloat)cellHeightForData:(id)data
{
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ColapsedMenuDropdown.png"]] frame].size.height;
}

-(void) updateCell
{
    [menuNameLabel setText:[theOption name]];
    [numberOfItemsLabel setText:[NSString stringWithFormat:@"%i Choices", [[theOption choiceList] count]]];    
    //Any of the changed associated with the data input in setData should occur here.
    //If the data is prone to changing, this cell should call updateCell via an NSNotificationCenter.
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

@end
