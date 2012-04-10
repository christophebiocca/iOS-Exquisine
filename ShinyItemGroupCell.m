//
//  ShinyItemGroupCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyItemGroupCell.h"
#import "ItemGroup.h"
#import "Item.h"
#import "Utilities.h"

@implementation ShinyItemGroupCell

-(id)init
{
    self = [super init];
    
    if (self) {
        cellImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ItemGroupNotSatisfied.png"]];
        
        [self addSubview:cellImage];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(92, 21, 120, 21)];
        [nameLabel setFont:[Utilities fravicHeadingFont]];
        [nameLabel setTextAlignment:UITextAlignmentCenter];
        [nameLabel setTextColor:[UIColor blackColor]];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setAdjustsFontSizeToFitWidth:YES];
        
        [self addSubview:cellImage];
        [self addSubview:nameLabel];
    }
    
    return self;
}

+(BOOL) canDisplayData:(id)data
{
    //Returns true iff the data passed in is meant to be displayed by this cell.
    return ([data isKindOfClass:[ItemGroup class]]);
}

+(NSString *) cellIdentifier
{
    //Must return a unique string identifier for this type of cell.
    return @"ShinyItemGroupCell";
}

-(void) setData:(id) data
{
    if (![[self class] canDisplayData:data])
    {
        CLLog(LOG_LEVEL_ERROR, @"An unsupported data type was sent to ShinyItemGroupCell's setData:");
        return;
    }
    
    theItemGroup = data;
    
    //If there is only one item, and the item only has no options, just automatically select it.
    if (([[theItemGroup listOfItems] count] == 1) && ([[(Item *)[[theItemGroup listOfItems] objectAtIndex:0] options] count] == 0)) {
        [theItemGroup setSatisfyingItem:[[theItemGroup listOfItems] objectAtIndex:0]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemGroupChanged) name:ITEM_GROUP_MODIFIED object:theItemGroup];
    
    [self updateCell];
}

+(CGFloat)cellHeightForData:(id)data
{
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ItemGroupNotSatisfied.png"]] frame].size.height;
}

-(void)itemGroupChanged
{
    [self updateCell];
}

-(void) updateCell
{
    if ([theItemGroup satisfied]) {
        [nameLabel setTextColor:[Utilities fravicDarkRedColor]];
        [nameLabel setText:[[theItemGroup satisfyingItem] name]];
        [cellImage setImage:[UIImage imageNamed:@"ItemGroupSatisfied.png"]];
    }
    else {
        [nameLabel setTextColor:[UIColor colorWithRed:(147.0/255.0) green:(147.0/255.0) blue:(147.0/255.0) alpha:1.0f]];
        [nameLabel setText:[NSString stringWithFormat:@"Select %@", [theItemGroup name]]];
        [cellImage setImage:[UIImage imageNamed:@"ItemGroupNotSatisfied.png"]];
    }
    
    //Any of the changed associated with the data input in setData should occur here.
    //If the data is prone to changing, this cell should call updateCell via an NSNotificationCenter.
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

@end
