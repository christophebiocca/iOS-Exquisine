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

@synthesize item;

+(NSString*)cellIdentifier{
    return @"ItemOrderCell";
}

static UIImage* deleteImage;

+(void)initialize{
    if(!deleteImage){
        deleteImage = [UIImage imageNamed:@"Delete"];
    }
}

-(void)setItem:(Item*)theItem{
    
    item = theItem;
    [super setMenuComponent:theItem];
    
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
