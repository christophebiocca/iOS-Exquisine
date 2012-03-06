//
//  ComboCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComboOrderCell.h"
#import "Combo.h"
#import "Utilities.h"
#import "NSMutableNumber.h"
#import <QuartzCore/QuartzCore.h>

@implementation ComboOrderCell

+(NSString *)cellIdentifier{
    return @"ComboOrderCell";
}

static UIImage* deleteImage = nil;

+(void)initialize{
    if(!deleteImage){
        deleteImage = [UIImage imageNamed:@"Delete"];
    }
}

-(void)setData:(id)theCombo{
    
    combo = theCombo;
    
    UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
    UIFont *descFont = [UIFont fontWithName:@"HelveticaNeue" size:13];
    [[self textLabel] setFont:titleFont];
    [[self detailTextLabel] setFont:descFont];
    
    [super setData:theCombo];
    
}

-(void)updateCell
{
    [super updateCell];
    [[self textLabel] setText:[NSString stringWithFormat:@"%@  x%i",[combo name], [[combo numberOfCombos] intValue]]];
    
    [[self detailTextLabel] setText:[Utilities FormatToPrice:[combo price]]];
    [self setNeedsDisplay];
}

-(void)willTransitionToState:(UITableViewCellStateMask)state{
    [super willTransitionToState:state];
    if(state & UITableViewCellStateShowingDeleteConfirmationMask){
        for(UIView* subview in [self subviews]){
            if([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationControl"]){
                UIView* buttonThingy = [[subview subviews] objectAtIndex:0];
                [[buttonThingy layer] setContents:(id)[deleteImage CGImage]];
            }
        }
    }
}

@end
