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
@synthesize indent;
@synthesize cellColour;
@synthesize disclosureArrow;
@synthesize height;

-(id)init
{
    self = [super init];
    
    if(self)
    {
        disclosureArrow = NO;
        title = @"";
        description = @"";
        indent = 0;
        cellColour = [UIColor whiteColor];
        height = 44.0f;
        titleFont = [UIFont fontWithName:@"AmericanTypewriter" size:14];
        descriptionFont = [UIFont fontWithName:@"AmericanTypewriter" size:14];
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

-(void)setIndent:(NSInteger)anIndent
{
    indent = anIndent;
    [[NSNotificationCenter defaultCenter] postNotificationName:VIEW_CELL_NEEDS_REDRAW object:self];
}

-(void)setCellColour:(UIColor *)aColour
{
    cellColour = aColour;
    [[NSNotificationCenter defaultCenter] postNotificationName:VIEW_CELL_NEEDS_REDRAW object:self];
}

-(void)setDisclosureArrow:(BOOL) boolValue
{
    disclosureArrow = boolValue;
    [[NSNotificationCenter defaultCenter] postNotificationName:VIEW_CELL_NEEDS_REDRAW object:self];
}

-(void)setHeight:(CGFloat)theHeight
{
    height = theHeight;
    [[NSNotificationCenter defaultCenter] postNotificationName:VIEW_CELL_NEEDS_REDRAW object:self];
}

@end
