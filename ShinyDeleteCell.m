//
//  ShinyDeleteCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyDeleteCell.h"

@implementation ShinyDeleteCell

-(id)init
{
    self = [super init];
    
    if (self) {
        cellImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DeleteButtonCell.png"]];
        
        [self addSubview:cellImage];
        
        deleteLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 150, 21)];
        [deleteLabel setFont:[Utilities fravicHeadingFont]];
        [deleteLabel setTextAlignment:UITextAlignmentCenter];
        [deleteLabel setTextColor:[UIColor blackColor]];
        [deleteLabel setBackgroundColor:[UIColor clearColor]];
        [deleteLabel setAdjustsFontSizeToFitWidth:YES];
               
        [self addSubview:cellImage];
        [self addSubview:deleteLabel];
    }
    
    return self;
}

+(BOOL) canDisplayData:(id)data
{
    //Returns true iff the data passed in is meant to be displayed by this cell.
    return ([data isKindOfClass:[NSDictionary class]] && [data valueForKey:@"deleteTitle"]);
}

+(NSString *) cellIdentifier
{
    //Must return a unique string identifier for this type of cell.
    return @"ShinyDeleteCell";
}

-(void) setData:(id) data
{
    if (![[self class] canDisplayData:data])
    {
        CLLog(LOG_LEVEL_ERROR, @"An unsupported data type was sent to ShinyDeleteCell's setData:");
        return;
    }
    
    deleteTitleInfo = data;
    
    [self updateCell];
}

+(CGFloat)cellHeightForData:(id)data
{
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DeleteButtonCell.png"]] frame].size.height;
}

-(void) updateCell
{
    [deleteLabel setText:[deleteTitleInfo valueForKey:@"deleteTitle"]];  
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

@end
