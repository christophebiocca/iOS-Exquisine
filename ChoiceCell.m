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

@synthesize choice;

+(NSString*)cellIdentifier{
    return @"ChoiceCell";
}

-(void)setChoice:(Choice*)theChoice{
    
    [super setMenuComponent:theChoice];
    choice = theChoice;
    
    UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
    UIFont *descFont = [UIFont fontWithName:@"HelveticaNeue" size:17];
    
    [[self textLabel] setFont:titleFont];
    [[self detailTextLabel] setFont:descFont];
    
    [[self detailTextLabel] setText:[Utilities FormatToPrice:[choice price]]];
    
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
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
