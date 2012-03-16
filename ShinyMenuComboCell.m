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
        
        comboNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 12, 196, 21)];
        [comboNameLabel setFont:[Utilities fravicHeadingFont]];
        [comboNameLabel setTextAlignment:UITextAlignmentCenter];
        [comboNameLabel setTextColor:[UIColor blackColor]];
        [comboNameLabel setBackgroundColor:[UIColor clearColor]];
        [comboNameLabel setAdjustsFontSizeToFitWidth:YES];
        
        comboPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(206, 10, 120, 21)];
        [comboPriceLabel setFont:[Utilities fravicHeadingFont]];
        [comboPriceLabel setTextAlignment:UITextAlignmentCenter];
        [comboPriceLabel setTextColor:[Utilities fravicDarkRedColor]];
        [comboPriceLabel setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:comboNameLabel];
        [self addSubview:comboPriceLabel];
    }
    
    return self;
}

+(CGFloat)cellHeightForData:(id)data
{
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ExpandedItemCell.png"]] frame].size.height;
}

-(void) updateCell
{
    [comboNameLabel setText:[theCombo name]];
    [comboPriceLabel setText:[Utilities FormatToPrice:[theCombo displayPrice]]];
    //Any of the changed associated with the data input in setData should occur here.
    //If the data is prone to changing, this cell should call updateCell via an NSNotificationCenter.
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

@end
