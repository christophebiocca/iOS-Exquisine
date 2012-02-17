//
//  ComboCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComboCell.h"
#import "Combo.h"
#import "Utilities.h"
#import <QuartzCore/QuartzCore.h>

@implementation ComboCell

@synthesize combo;
@synthesize style;

+(NSString *)cellIdentifier{
    return @"ComboCell";
}

static UIImage* deleteImage = nil;

+(void)initialize{
    if(!deleteImage){
        deleteImage = [UIImage imageNamed:@"Delete"];
    }
}

-(void)setCombo:(Combo*)theCombo{
    
    combo = theCombo;
    
    [super setMenuComponent:theCombo];
    
    [[self detailTextLabel] setText:@""];
    
    style = CELL_STYLE_PLAIN;
    [self setStyle:style];
    
}

-(void)setStyle:(CellStyle)aStyle
{
    
    switch (aStyle) {
        case CELL_STYLE_PLAIN:
            [self setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
            [self setBackgroundColor:[UIColor whiteColor]];
            break;
        case CELL_STYLE_FANCY:
            if([combo satisfied])
            {
                [self setAccessoryType:UITableViewCellAccessoryCheckmark];
                [self setBackgroundColor:[UIColor colorWithRed:0.6f green:0.9f blue:0.6f alpha:1.0f]];
            }
            else
            {
                [self setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
                [self setBackgroundColor:[UIColor whiteColor]];
            }
            break;
            
        default:
            break;
    }
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

@end
