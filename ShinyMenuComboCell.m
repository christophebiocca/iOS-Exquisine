//
//  ShinyMenuComboCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyMenuComboCell.h"
#import "Combo.h"

@implementation ShinyMenuComboCell

+(BOOL) canDisplayData:(id)data
{
    return [data isKindOfClass:[NSDictionary class]] && [data objectForKey:@"menuCombo"];
}

+(NSString *) cellIdentifier
{
    //Must return a unique string identifier for this type of cell.
    return @"ShinyMenuComboCell";
}

-(void) setData:(id) data
{
    if (![[self class] canDisplayData:data])
    {
        CLLog(LOG_LEVEL_ERROR, @"An unsupported data type was sent to ShinyMenuComboCell's setData:");
        return;
    }

    theCombo = [data objectForKey:@"menuCombo"];
    
    [self updateCell];
}

-(id)init
{
    self = [super init];
    
    if (self) {
        itemImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ExpandedItemCell.png"]];
        
        [self addSubview:itemImage];
        
        itemNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 14, 196, 21)];
        [itemNameLabel setFont:[Utilities fravicHeadingFont]];
        [itemNameLabel setTextAlignment:UITextAlignmentCenter];
        [itemNameLabel setTextColor:[UIColor blackColor]];
        [itemNameLabel setBackgroundColor:[UIColor clearColor]];
        
        itemPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(206, 12, 120, 21)];
        [itemPriceLabel setFont:[Utilities fravicHeadingFont]];
        [itemPriceLabel setTextAlignment:UITextAlignmentCenter];
        [itemPriceLabel setTextColor:[Utilities fravicDarkRedColor]];
        [itemPriceLabel setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:itemNameLabel];
        [self addSubview:itemPriceLabel];
    }
    
    return self;
}

+(CGFloat)cellHeightForData:(id)data
{
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ExpandedItemCell.png"]] frame].size.height;
}

-(void) updateCell
{
    [itemNameLabel setText:[theCombo name]];
    [itemPriceLabel setText:[Utilities FormatToPrice:[theCombo displayPrice]]];
    //Any of the changed associated with the data input in setData should occur here.
    //If the data is prone to changing, this cell should call updateCell via an NSNotificationCenter.
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

@end
