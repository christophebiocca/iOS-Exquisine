//
//  ShinyItemFavoriteCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyItemFavoriteCell.h"
#import "Item.h"
#import "AppData.h"

@implementation ShinyItemFavoriteCell

static float pulseTime = 1.0;

-(id)init
{
    self = [super init];
    
    if (self) {
        displayImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FavoriteCellEmpty.png"]];
        
        displayMessage = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 150, 21)];
        [displayMessage setFont:[Utilities fravicHeadingFont]];
        [displayMessage setTextAlignment:UITextAlignmentCenter];
        [displayMessage setTextColor:[UIColor blackColor]];
        [displayMessage setBackgroundColor:[UIColor clearColor]];
        [displayMessage setAdjustsFontSizeToFitWidth:YES];
        
        [self addSubview:displayImage];
        [self addSubview:displayMessage];
    }
    
    return self;
}

+(BOOL) canDisplayData:(id)data
{
    //Returns true iff the data passed in is meant to be displayed by this cell.
    return ([data isKindOfClass:[NSDictionary class]] && [data objectForKey:@"favoriteCellItem"]);
}

+(NSString *) cellIdentifier
{
    //Must return a unique string identifier for this type of cell.
    return @"ShinyItemFavoriteCell";
}

-(void) setData:(id) data
{
    if (![[self class] canDisplayData:data])
    {
        CLLog(LOG_LEVEL_ERROR, @"An unsupported data type was sent to ShinyItemFavoriteCell's setData:");
        return;
    }
    
    theItem = [data objectForKey:@"favoriteCellItem"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCell) name:ITEM_MODIFIED object:theItem];
    
    [self updateCell];
}

+(CGFloat)cellHeightForData:(id)data
{
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FavoriteCellEmpty.png"]] frame].size.height;
}

-(void)fadePulse:(UIView *)aView
{
    
    [UIView beginAnimations: @"out" context:nil];
    [UIView setAnimationDuration:(pulseTime/2)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    aView.alpha = 0.0;
    [UIView commitAnimations];
    [self performSelector:@selector(fadeBackIn:) withObject:aView afterDelay:(pulseTime/2 + 0.001)];
}

-(void)fadeBackIn:(UIView *) aView
{
    aView.alpha = 0.3;
    [UIView beginAnimations: @"in" context:nil];
    [UIView setAnimationDuration:pulseTime];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    aView.alpha = 1.0;
    [UIView commitAnimations];
}

-(void)wasClicked
{
    
    [[AppData appData] toggleFavoriteItem:theItem];
    [self fadeBackIn:displayImage];
    [self updateCell];
}

-(void) updateCell
{
    [displayMessage setText:@"Favorite"];
    
    if ([[AppData appData] isFavoriteItem:theItem]) {
        [displayImage setImage:[UIImage imageNamed:@"FavoriteCellSolid.png"]];
    }
    else
    {
        [displayImage setImage:[UIImage imageNamed:@"FavoriteCellEmpty.png"]];
    }
    
    //Any of the changed associated with the data input in setData should occur here.
    //If the data is prone to changing, this cell should call updateCell via an NSNotificationCenter.
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

@end
