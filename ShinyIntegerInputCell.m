//
//  IntegerInputCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyIntegerInputCell.h"
#import "IntegerInputCellData.h"
#import "NSMutableNumber.h"
#import <QuartzCore/QuartzCore.h>

@implementation ShinyIntegerInputCell

-(id)init
{
    self = [super init];
    
    if(self)
    {
        theImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NumberInputCell.png"]];
        
        integerCellData = [[IntegerInputCellData alloc] init];
        numberLabel = [[UILabel alloc] init];
        [numberLabel setBackgroundColor:[UIColor clearColor]];
        [numberLabel setFont:[UIFont fontWithName:@"AmericanTypewriter-Bold" size:13]];
        
        plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setTitle:@" " forState:UIControlStateNormal];
        [plusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [minusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [minusButton setTitle:@" " forState:UIControlStateNormal];
        
        [plusButton addTarget:self action:@selector(plusPushed) forControlEvents:UIControlEventTouchUpInside];
        [minusButton addTarget:self action:@selector(minusPushed) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:theImage];
        [self addSubview:numberLabel];
        [self addSubview:plusButton];
        [self addSubview:minusButton];
        
        [self updateCell];
    }
    
    return self;
}

+(NSString *)cellIdentifier
{
    return @"IntegerInputCell";
}

-(void)layoutSubviews
{
    [minusButton setFrame:CGRectMake(
                                    10, 
                                    [self frame].size.height/2 - 22, 
                                    40, 
                                    40)];
    [plusButton setFrame:CGRectMake(
                                     270, 
                                     [self frame].size.height/2 - 22, 
                                     40, 
                                     40)];
    [numberLabel setFrame:CGRectMake(
                                     156, 
                                     [self frame].size.height/2 - 10, 
                                     180, 
                                     21)];
}

+(BOOL)canDisplayData:(id)data
{
    return [data isKindOfClass:[IntegerInputCellData class]];
}

-(void)setData:(id)data
{
    if ([data isKindOfClass:[IntegerInputCellData class]]) 
    {
        integerCellData = data;
    }
    else
    {
        CLLog(LOG_LEVEL_ERROR, @"An incorrect data type was sent to IntegerInputCell:setData:");
    }
    
    [self updateCell];
}

-(void) updateCell
{
    [numberLabel setText:[NSString stringWithFormat:@"%i",[[integerCellData number] intValue]]];
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

-(void)plusPushed
{
    [integerCellData plus];
    [self updateCell];
}

-(void)minusPushed
{
    [integerCellData minus];
    [self updateCell];
}

+(CGFloat)cellHeightForData:(id)data
{
    //This should be programatic. Trying to get it done quickly.
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NumberInputCell.png"]]frame].size.height;
}

@end
