//
//  GeneralPurposeViewCellData.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeneralPurposeViewCellData.h"

NSString* VIEW_CELL_NEEDS_REDRAW = @"CroutonLabs/ViewCellNeedsRedraw";

@implementation GeneralPurposeViewCellData

@synthesize title;
@synthesize titleFont;
@synthesize description;
@synthesize descriptionFont;

-(id)init
{
    self = [super init];
    
    if(self)
    {
        title = @"";
        description = @"";
    }
    
    return self;
}

-(void)setTitle:(NSString *)aTitle
{
    title = aTitle;
    [[NSNotificationCenter defaultCenter] postNotificationName:VIEW_CELL_NEEDS_REDRAW object:self];
}

-(void)setTitleFont:(UIFont *)aFont
{
    titleFont = aFont;
    [[NSNotificationCenter defaultCenter] postNotificationName:VIEW_CELL_NEEDS_REDRAW object:self];
}

-(void)setDescription:(NSString *)aDescription
{
    description = aDescription;
    [[NSNotificationCenter defaultCenter] postNotificationName:VIEW_CELL_NEEDS_REDRAW object:self];
}

-(void)setDescriptionFont:(UIFont *)aFont
{
    descriptionFont = aFont;
    [[NSNotificationCenter defaultCenter] postNotificationName:VIEW_CELL_NEEDS_REDRAW object:self];
}

@end
