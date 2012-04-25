//
//  ActivePromoCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActivePromoCell.h"
#import "ActivePromo.h"

@implementation ActivePromoCell

-(id)init
{
    self = [super init];
    
    if (self) {
        cellImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ActivePromoCell.png"]];
        
        [self addSubview:cellImage];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 6, 182, 21)];
        [nameLabel setFont:[Utilities fravicHeadingFont]];
        [nameLabel setTextAlignment:UITextAlignmentCenter];
        [nameLabel setTextColor:[UIColor blackColor]];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setAdjustsFontSizeToFitWidth:YES];
        
        descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 26, 182, 50)];
        [descriptionLabel setFont:[Utilities fravicTextFont]];
        [descriptionLabel setTextAlignment:UITextAlignmentCenter];
        [descriptionLabel setNumberOfLines:3];
        [descriptionLabel setLineBreakMode:UILineBreakModeWordWrap];
        [descriptionLabel setTextColor:[UIColor blackColor]];
        [descriptionLabel setBackgroundColor:[UIColor clearColor]];
        [descriptionLabel setAdjustsFontSizeToFitWidth:YES];
        
        saveLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 20, 80, 21)];
        [saveLabel setFont:[Utilities fravicHeadingFont]];
        [saveLabel setTextAlignment:UITextAlignmentCenter];
        [saveLabel setTextColor:[UIColor blackColor]];
        [saveLabel setBackgroundColor:[UIColor clearColor]];
        [saveLabel setAdjustsFontSizeToFitWidth:YES];
        
        savePriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 40, 80, 21)];
        [savePriceLabel setFont:[Utilities fravicHeadingFont]];
        [savePriceLabel setTextAlignment:UITextAlignmentCenter];
        [savePriceLabel setTextColor:[UIColor blackColor]];
        [savePriceLabel setBackgroundColor:[UIColor clearColor]];
        [savePriceLabel setAdjustsFontSizeToFitWidth:YES];
        
        [self addSubview:cellImage];
        [self addSubview:nameLabel];
        [self addSubview:descriptionLabel];
        [self addSubview:saveLabel];
        [self addSubview:savePriceLabel];
    }
    
    return self;
}

+(BOOL) canDisplayData:(id)data
{
    //Returns true iff the data passed in is meant to be displayed by this cell.
    return ([data isKindOfClass:[ActivePromo class]]);
}

+(NSString *) cellIdentifier
{
    //Must return a unique string identifier for this type of cell.
    return @"ActivePromoCell";
}

-(void) setData:(id) data
{
    if (![[self class] canDisplayData:data])
    {
        CLLog(LOG_LEVEL_ERROR, @"An unsupported data type was sent to ActivePromoCell's setData:");
        return;
    }
    
    thePromo = data;
    
    [self updateCell];
}

+(CGFloat)cellHeightForData:(id)data
{
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ActivePromoCell.png"]] frame].size.height;
}

-(void) updateCell
{
    [nameLabel setText:[thePromo name]];
    [descriptionLabel setText:[thePromo description]];
    [saveLabel setText:@"Save"];
    [savePriceLabel setText:[Utilities FormatToPrice:[thePromo promoPrice]]];
    //Any of the changed associated with the data input in setData should occur here.
    //If the data is prone to changing, this cell should call updateCell via an NSNotificationCenter.
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

@end
