//
//  ShinyMenuItemCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyMenuItemCell.h"
#import "Item.h"

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

-(id)init
{
    self = [super init];
    
    if (self) {
        itemImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ExpandedItemCell.png"]];
        
        [self addSubview:itemImage];
        
        itemNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 12, 196, 21)];
        [itemNameLabel setFont:[Utilities fravicHeadingFont]];
        [itemNameLabel setTextAlignment:UITextAlignmentCenter];
        [itemNameLabel setTextColor:[UIColor blackColor]];
        [itemNameLabel setBackgroundColor:[UIColor clearColor]];
        [itemNameLabel setAdjustsFontSizeToFitWidth:YES];
        
        itemPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(206, 10, 120, 21)];
        [itemPriceLabel setFont:[Utilities fravicHeadingFont]];
        [itemPriceLabel setTextAlignment:UITextAlignmentCenter];
        [itemPriceLabel setTextColor:[Utilities fravicDarkRedColor]];
        [itemPriceLabel setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:itemNameLabel];
        [self addSubview:itemPriceLabel];
    }
    
    return self;
}


-(void) setData:(id) data
{
    if (![[self class] canDisplayData:data])
    {
        CLLog(LOG_LEVEL_ERROR, @"An unsupported data type was sent to ShinyMenuItemCell's setData:");
        return;
    }
    theItem = [data objectForKey:@"menuItem"];
    [self updateCell];
}

+(CGFloat)cellHeightForData:(id)data
{
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ExpandedItemCell.png"]] frame].size.height;
}

-(void) updateCell
{
    [itemNameLabel setText:[theItem name]];
    [itemPriceLabel setText:[Utilities FormatToPrice:[theItem price]]];
    //Any of the changed associated with the data input in setData should occur here.
    //If the data is prone to changing, this cell should call updateCell via an NSNotificationCenter.
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

@end
