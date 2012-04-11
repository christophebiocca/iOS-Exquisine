//
//  ShinyOrderHistoryCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyOrderHistoryCell.h"
#import "Order.h"

@implementation ShinyOrderHistoryCell

-(id)init
{
    self = [super init];
    
    if (self) {
        cellImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OrderHistoryCell.png"]];
        
        [self addSubview:cellImage];
        
        statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 17, 170, 21)];
        [statusLabel setFont:[Utilities fravicHeadingFont]];
        [statusLabel setTextAlignment:UITextAlignmentCenter];
        [statusLabel setTextColor:[UIColor blackColor]];
        [statusLabel setBackgroundColor:[UIColor clearColor]];
        [statusLabel setAdjustsFontSizeToFitWidth:YES];
        
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 33, 170, 21)];
        [dateLabel setFont:[Utilities fravicHeadingFont]];
        [dateLabel setTextAlignment:UITextAlignmentCenter];
        [dateLabel setTextColor:[UIColor blackColor]];
        [dateLabel setBackgroundColor:[UIColor clearColor]];
        [dateLabel setAdjustsFontSizeToFitWidth:YES];
        
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(206, 23, 48, 21)];
        [priceLabel setFont:[Utilities fravicHeadingFont]];
        [priceLabel setTextAlignment:UITextAlignmentCenter];
        [priceLabel setTextColor:[UIColor blackColor]];
        [priceLabel setBackgroundColor:[UIColor clearColor]];
        [priceLabel setAdjustsFontSizeToFitWidth:YES];
        
        [self addSubview:cellImage];
        [self addSubview:dateLabel];
        [self addSubview:priceLabel];
        [self addSubview:statusLabel];
    }
    
    return self;
}

+(BOOL) canDisplayData:(id)data
{
    //Returns true iff the data passed in is meant to be displayed by this cell.
    return ([data isKindOfClass:[NSDictionary class]] && [data valueForKey:@"historicalOrder"]);
}

+(NSString *) cellIdentifier
{
    //Must return a unique string identifier for this type of cell.
    return @"ShinyOrderHistoryCell";
}

-(void) setData:(id) data
{
    if (![[self class] canDisplayData:data])
    {
        CLLog(LOG_LEVEL_ERROR, @"An unsupported data type was sent to ShinyOrderHistoryCell's setData:");
        return;
    }
    
    orderInfo = data;
    
    [self updateCell];
}

+(CGFloat)cellHeightForData:(id)data
{
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OrderHistoryCell.png"]] frame].size.height;
}

-(void) updateCell
{
    Order *theOrder = [orderInfo valueForKey:@"historicalOrder"];
    [dateLabel setText:[Utilities FormatToDate:[theOrder mostRecentSubmitDate]]];
    [priceLabel setText:[Utilities FormatToPrice:[theOrder totalPrice]]];
    [statusLabel setText:[theOrder status]];
    //Any of the changed associated with the data input in setData should occur here.
    //If the data is prone to changing, this cell should call updateCell via an NSNotificationCenter.
    [self setNeedsLayout];
    [self setNeedsDisplay];
}



@end
