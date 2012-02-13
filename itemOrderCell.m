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

- (id)init
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[ItemOrderCell cellIdentifier]];
    if (self) {
        deleteImage = [UIImage imageNamed:@"Delete"];
    }
    return self;
}

-(void)setItem:(Item*)theItem{
    
    item = theItem;
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
    UIFont *descFont = [UIFont fontWithName:@"HelveticaNeue" size:13];
    
    [[self textLabel] setFont:titleFont];
    [[self detailTextLabel] setFont:descFont];
    
    [[self textLabel] setText:[item name]];
    [[self detailTextLabel] setText:[Utilities FormatToPrice:[item price]]];
    
}

-(void)willTransitionToState:(UITableViewCellStateMask)state{
    [super willTransitionToState:state];
    if(state & UITableViewCellStateShowingDeleteConfirmationMask){
        NSLog(@"transition");
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
    
    // Configure the view for the selected state
}

@end
