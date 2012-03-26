//
//  ShinyItemRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyItemRenderer.h"
#import "OptionSectionHeaderView.h"
#import "NumberOfItemsSectionHeaderView.h"
#import "IntegerInputCellData.h"
#import "Option.h"
#import "Item.h"

@implementation ShinyItemRenderer

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
        
        [sectionNames addObject:@"Options"];
        NSMutableArray *optionSectionContents = [[NSMutableArray alloc] init];
        
        [optionSectionContents addObject:[OptionSectionHeaderView new]];
        
        //Starts with all of the options in the open position.
        for (Option *eachOption in [theItem options]) {
            NSMutableDictionary *newDictionary = [[NSMutableDictionary alloc] init];
            [newDictionary setObject:eachOption forKey:@"openOption"];
            [optionSectionContents addObject:newDictionary];
            for (Choice *eachChoice in [eachOption choiceList])
            {
                newDictionary = [[NSMutableDictionary alloc] init];
                [newDictionary setObject:eachChoice forKey:@"choice"];
                [optionSectionContents addObject:newDictionary];
            }
        }
        
        [listData addObject:optionSectionContents];
    }
    
    return self;
}

@end
