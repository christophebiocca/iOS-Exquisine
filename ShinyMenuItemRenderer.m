//
//  ShinyItemRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyMenuItemRenderer.h"
#import "OptionSectionHeaderView.h"
#import "NumberOfItemsSectionHeaderView.h"
#import "ExpandableCellData.h"
#import "IntegerInputCellData.h"
#import "Option.h"
#import "Item.h"

@implementation ShinyMenuItemRenderer

-(id)initWithItem:(Item *)anItem
{
    self = [super init];
    
    if(self)
    {
        
        theItem = anItem;
        
        sectionNames = [[NSMutableArray alloc] init];
        listData = [[NSMutableArray alloc] init];
        
        [sectionNames addObject:@"Item Quantity"];
        NSMutableArray *numberOfItemsSectionContents = [[NSMutableArray alloc] init];
        
        [numberOfItemsSectionContents addObject:[NumberOfItemsSectionHeaderView new]];
        IntegerInputCellData *newCell = [[IntegerInputCellData alloc] init];
        [newCell setNumber:[theItem numberOfItems]];
        [newCell setLowerBound:[NSNumber numberWithInt:1]];
        [newCell setUpperBound:[NSNumber numberWithInt:100]];
        [numberOfItemsSectionContents addObject:newCell];
        
        [listData addObject:numberOfItemsSectionContents];
        
        if ([[theItem options] count] != 0) {
            [sectionNames addObject:@"Options"];
            NSMutableArray *optionSectionContents = [[NSMutableArray alloc] init];
            
            [optionSectionContents addObject:[OptionSectionHeaderView new]];
            
            for (Option *eachOption in [theItem options]) {
                [optionSectionContents addObject:[[ExpandableCellData alloc] initWithPrimaryItem:eachOption AndRenderer:self]];
            }
            
            [listData addObject:optionSectionContents];
        }
        
    }
    
    return self;
}

@end