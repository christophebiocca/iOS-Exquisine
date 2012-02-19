//
//  itemOrderCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemOrderCell.h"
#import "Item.h"
#import "Utilities.h"
#import <QuartzCore/QuartzCore.h>

@implementation ItemOrderCell

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
    
    UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
    UIFont *descFont = [UIFont fontWithName:@"HelveticaNeue" size:13];
    [[self textLabel] setFont:titleFont];
    [[self detailTextLabel] setFont:descFont];
    
    [self updateCell];
}

-(void)updateCell
{
    [super updateCell];
    
    [[self detailTextLabel] setText:[Utilities FormatToPrice:[item price]]];
    
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
