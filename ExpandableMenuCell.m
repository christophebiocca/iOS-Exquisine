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
    
    //This is bad form, but it will initialize the expandableData 
    //into the appropriate state if need be.
    if ([[expandableData expansionContents] count] == 0) {
        for (id eachItem in [[expandableData primaryItem] submenuList])
        {
            if ([eachItem isKindOfClass:[Item class]]) {
                NSMutableDictionary *newDictionary;
                newDictionary = [[NSMutableDictionary alloc] init];
                [newDictionary setObject:eachItem forKey:@"menuItem"];
                [[expandableData expansionContents] addObject:newDictionary];
            }
        
        } 
        for (Combo *eachCombo in [[expandableData primaryItem] comboList]) {
            NSMutableDictionary *newDictionary;
            newDictionary = [[NSMutableDictionary alloc] init];
            [newDictionary setObject:eachCombo forKey:@"menuCombo"];
            [[expandableData expansionContents] addObject:newDictionary];
        }
    }
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

+(NSString *)cellIdentifier
{
    return @"ExpandableMenuCell";
}


@end
