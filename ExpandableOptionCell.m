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
    
    //This is bad form, but it will initialize the expandableData 
    //into the appropriate state if need be.
    if ([[expandableData expansionContents] count] == 0) {
        for (Choice *eachChoice in [[expandableData primaryItem] choiceList])
        {
            NSMutableDictionary *newDictionary;
            newDictionary = [[NSMutableDictionary alloc] init];
            [newDictionary setObject:eachChoice forKey:@"choice"];
            [[expandableData expansionContents] addObject:newDictionary];
        } 
    }
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

+(NSString *)cellIdentifier
{
    return @"ExpandableOptionCell";
}

@end
