//
//  IntegerInputCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IntegerInputCell.h"
#import "IntegerInputCellData.h"
#import "NSMutableNumber.h"
#import <QuartzCore/QuartzCore.h>

@implementation IntegerInputCell

-(id)init
{
    self = [super init];
    
    if(self)
    {
        integerCellData = [[IntegerInputCellData alloc] init];
        numberLabel = [[UILabel alloc] init];
        [numberLabel setBackgroundColor:[UIColor clearColor]];
        plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setTitle:@"+" forState:UIControlStateNormal];
        [plusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [minusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [minusButton setTitle:@"-" forState:UIControlStateNormal];
        
        
        [plusButton addTarget:self action:@selector(plusPushed) forControlEvents:UIControlEventTouchUpInside];
        [minusButton addTarget:self action:@selector(minusPushed) forControlEvents:UIControlEventTouchUpInside];
        
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
                                    20, 
                                    [self frame].size.height/2 - 15, 
                                    30, 
                                    30)];
    [plusButton setFrame:CGRectMake(
                                     65, 
                                     [self frame].size.height/2 - 15, 
                                     30, 
                                     30)];
    [numberLabel setFrame:CGRectMake(
                                     125, 
                                     [self frame].size.height/2 - 10, 
                                     180, 
                                     21)];
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
    [numberLabel setText:[NSString stringWithFormat:@"%@: %i",[integerCellData numberPrompt],[[integerCellData number] intValue]]];
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

@end
