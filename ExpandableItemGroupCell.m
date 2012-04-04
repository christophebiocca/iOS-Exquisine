//
//  ExpandableItemGroupCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExpandableItemGroupCell.h"
#import "ExpandableCellData.h"
#import "ItemGroup.h"

@implementation ExpandableItemGroupCell

+(BOOL)canDisplayData:(id)data
{
    if ([data isKindOfClass:[ExpandableCellData class]]) {
        if ([[data primaryItem] isKindOfClass:[ItemGroup class]]) {
            return YES;
        }
    }
    return NO;
}

-(void)setData:(id)data
{
    [super setData:data];
    [nameLabel setText:[[expandableData primaryItem] name]];
    [numberOfItemsLabel setText:[NSString stringWithFormat:@"Items: %i", [[[expandableData primaryItem] listOfItems] count]]];
    
    //This is bad form, but it will initialize the expandableData 
    //into the appropriate state if need be.
    if ([[expandableData expansionContents] count] == 0) {
        for (Item *eachItem in [[expandableData primaryItem] listOfItems])
        {
            NSMutableDictionary *newDictionary;
            newDictionary = [[NSMutableDictionary alloc] init];
            [newDictionary setObject:eachItem forKey:@"menuItem"];
            [[expandableData expansionContents] addObject:newDictionary];
        } 
    }
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

+(NSString *)cellIdentifier
{
    return @"ExpandableItemGroupCell";
}

@end
