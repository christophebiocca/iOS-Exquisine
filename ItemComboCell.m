//
//  ItemComboCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemComboCell.h"
#import "Item.h"
#import "Utilities.h"
#import <QuartzCore/QuartzCore.h>

@implementation ItemComboCell
+(NSString*)cellIdentifier{
    return @"ItemOrderCell";
}

static UIImage* deleteImage;

+(void)initialize{
    if(!deleteImage){
        deleteImage = [UIImage imageNamed:@"Delete"];
    }
}

-(void)setData:(id)theItem{
    
    item = theItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCell) name:ITEM_MODIFIED object:item];
    
    [super setData:theItem];
    
    [self setIndentationLevel:3];
    
    [self updateCell];
}

-(void)updateCell
{
    [super updateCell];
    
    [[self detailTextLabel] setText:@""];
    
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
