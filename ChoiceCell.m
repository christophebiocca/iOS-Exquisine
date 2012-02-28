//
//  ChoiceCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChoiceCell.h"
#import "Choice.h"
#import "Utilities.h"

@implementation ChoiceCell

+(NSString*)cellIdentifier
{
    return @"ChoiceCell";
}

-(void)setData:(id)theChoice
{
    
    [super setData:theChoice];
    choice = theChoice;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCell) name:CHOICE_CHANGED object:theChoice];
    
    UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
    UIFont *descFont = [UIFont fontWithName:@"HelveticaNeue" size:17];
    
    [[self textLabel] setFont:titleFont];
    [[self detailTextLabel] setFont:descFont];
    
    [self updateCell];
    
}

-(void)updateCell
{
    [super updateCell];
    if (!([[choice price] compare:[NSNumber numberWithInt:0]] == NSOrderedSame)) {
        [[self detailTextLabel] setText:[Utilities FormatToPrice:[choice price]]];
    }
    else
    {
        [[self detailTextLabel] setText:@""];
    }
    
    if ([choice selected])
    {
        [self setAccessoryType:UITableViewCellAccessoryCheckmark];
        [self setBackgroundColor:[UIColor colorWithRed:0.83f green:1.0f blue:0.83f alpha:1.0f]];
    }
    else
    {
        [self setAccessoryType:UITableViewCellAccessoryNone];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    [self setNeedsDisplay];
}

@end
