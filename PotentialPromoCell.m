//
//  PotentialPromoCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PotentialPromoCell.h"
#import "PotentialPromo.h"

@implementation PotentialPromoCell

-(id)init
{
    self = [super init];
    
    if (self) {
        cellImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PotentialPromoCell.png"]];
        
        [self addSubview:cellImage];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(92, 21, 120, 21)];
        [nameLabel setFont:[Utilities fravicHeadingFont]];
        [nameLabel setTextAlignment:UITextAlignmentCenter];
        [nameLabel setTextColor:[UIColor blackColor]];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setAdjustsFontSizeToFitWidth:YES];
        
        [self addSubview:cellImage];
        [self addSubview:nameLabel];
    }
    
    return self;
}

+(BOOL) canDisplayData:(id)data
{
    //Returns true iff the data passed in is meant to be displayed by this cell.
    return ([data isKindOfClass:[PotentialPromo class]]);
}

+(NSString *) cellIdentifier
{
    //Must return a unique string identifier for this type of cell.
    return @"PotentialPromoCell";
}

-(void) setData:(id) data
{
    if (![[self class] canDisplayData:data])
    {
        CLLog(LOG_LEVEL_ERROR, @"An unsupported data type was sent to PotentialPromoCell's setData:");
        return;
    }
    
    thePromo = data;
    
    [self updateCell];
}

+(CGFloat)cellHeightForData:(id)data
{
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PotentialPromoCell.png"]] frame].size.height;
}

-(void) updateCell
{
    [nameLabel setText:[thePromo name]];
    //Any of the changed associated with the data input in setData should occur here.
    //If the data is prone to changing, this cell should call updateCell via an NSNotificationCenter.
    [self setNeedsLayout];
    [self setNeedsDisplay];
}



@end
