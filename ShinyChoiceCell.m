//
//  ShinyChoiceCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyChoiceCell.h"
#import "Choice.h"

@implementation ShinyChoiceCell

static float pulseTime = 1.0;

-(id)init
{
    self = [super init];
    
    if (self) {
        choiceImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ChoiceCellWithPriceSelected.png"]];
        
        [self addSubview:choiceImage];
        
        choiceNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 12, 150, 21)];
        [choiceNameLabel setFont:[Utilities fravicHeadingFont]];
        [choiceNameLabel setTextAlignment:UITextAlignmentCenter];
        [choiceNameLabel setTextColor:[UIColor blackColor]];
        [choiceNameLabel setBackgroundColor:[UIColor clearColor]];
        [choiceNameLabel setAdjustsFontSizeToFitWidth:YES];
        
        choicePriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 10, 120, 21)];
        [choicePriceLabel setFont:[Utilities fravicHeadingFont]];
        [choicePriceLabel setTextAlignment:UITextAlignmentCenter];
        [choicePriceLabel setTextColor:[Utilities fravicDarkRedColor]];
        [choicePriceLabel setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:choiceImage];
        [self addSubview:choiceNameLabel];
        [self addSubview:choicePriceLabel];
    }
    
    return self;
}

+(BOOL) canDisplayData:(id)data
{
    //Returns true iff the data passed in is meant to be displayed by this cell.
    return ([data isKindOfClass:[NSDictionary class]] && [data objectForKey:@"choice"]);
}

+(NSString *) cellIdentifier
{
    //Must return a unique string identifier for this type of cell.
    return @"ShinyChoiceCell";
}

-(void) setData:(id) data
{
    if (![[self class] canDisplayData:data])
    {
        CLLog(LOG_LEVEL_ERROR, @"An unsupported data type was sent to ShinyChoiceCell's setData:");
        return;
    }

    theChoice = [data objectForKey:@"choice"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(choiceChanged) name:CHOICE_CHANGED object:theChoice];
    
    [self updateCell];
}

+(CGFloat)cellHeightForData:(id)data
{
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ChoiceCellWithoutPriceNotSelected.png"]] frame].size.height;
}

-(void)fadePulse:(UIView *)aView
{
    
    [UIView beginAnimations: @"out" context:nil];
    [UIView setAnimationDuration:(pulseTime/2)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    aView.alpha = 0.0;
    [UIView commitAnimations];
    [self performSelector:@selector(fadeBackIn:) withObject:aView afterDelay:(pulseTime/2 + 0.001)];
}

-(void)fadeBackIn:(UIView *) aView
{
    aView.alpha = 0.3;
    [UIView beginAnimations: @"in" context:nil];
    [UIView setAnimationDuration:pulseTime];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    aView.alpha = 1.0;
    [UIView commitAnimations];
}

-(void)pulseView
{
    [self fadeBackIn:choiceImage];
}

-(void)choiceChanged
{
    [self updateCell];
}

-(void) updateCell
{
    [choiceNameLabel setText:[theChoice name]];
    
    if ([theChoice isFree]) {
        [choicePriceLabel setText:@""];
        if ([theChoice selected]) {
            [choiceImage setImage:[UIImage imageNamed:@"ChoiceCellWithoutPriceSelected.png"]];
        }
        else
        {
            [choiceImage setImage:[UIImage imageNamed:@"ChoiceCellWithoutPriceNotSelected.png"]];
        }
    }
    else
    {
        [choicePriceLabel setText:[Utilities FormatToPrice:[theChoice price]]];
        if ([theChoice selected]) {
            [choiceImage setImage:[UIImage imageNamed:@"ChoiceCellWithPriceSelected.png"]];
        }
        else
        {
            [choiceImage setImage:[UIImage imageNamed:@"ChoiceCellWithPriceNotSelected.png"]];
        }
    }
    
    //Any of the changed associated with the data input in setData should occur here.
    //If the data is prone to changing, this cell should call updateCell via an NSNotificationCenter.
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

@end
