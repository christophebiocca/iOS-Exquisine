//
//  ExpandableOptionCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExpandableOptionCell.h"
#import "ExpandableCellData.h"
#import "Option.h"

@implementation ExpandableOptionCell

+(BOOL)canDisplayData:(id)data
{
    if ([data isKindOfClass:[ExpandableCellData class]]) {
        if ([[data primaryItem] isKindOfClass:[Option class]]) {
            return YES;
        }
    }
    return NO;
}

-(void)setData:(id)data
{
    [super setData:data];
    [nameLabel setText:[[expandableData primaryItem] name]];
    [numberOfItemsLabel setText:[NSString stringWithFormat:@"Choices: %i", [[[expandableData primaryItem] choiceList] count]]];
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

+(NSString *)cellIdentifier
{
    return @"ExpandableOptionCell";
}

@end
