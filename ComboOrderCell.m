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

-(void)setMenuComponent:(Combo*)theCombo{
    
    combo = theCombo;
    
    [super setMenuComponent:theCombo];
    
}

-(void)updateCell
{
    [super updateCell];
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
