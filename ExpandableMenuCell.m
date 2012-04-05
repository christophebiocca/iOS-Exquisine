//
//  ExpandableMenuCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-03.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExpandableMenuCell.h"
#import "ExpandableCellData.h"
#import "Menu.h"
#import "Combo.h"
#import "Item.h"

@implementation ExpandableMenuCell

+(BOOL)canDisplayData:(id)data
{
    if ([data isKindOfClass:[ExpandableCellData class]]) {
        if ([[data primaryItem] isKindOfClass:[Menu class]]) {
            return YES;
        }
    }
    return NO;
}

-(void)setData:(id)data
{
    [super setData:data];
    [nameLabel setText:[[expandableData primaryItem] name]];
    [numberOfItemsLabel setText:[NSString stringWithFormat:@"Items: %i", ([[[expandableData primaryItem] submenuList] count] + [[[expandableData primaryItem] comboList] count])]];
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

+(NSString *)cellIdentifier
{
    return @"ExpandableMenuCell";
}


@end
