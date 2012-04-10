//
//  ShinyComboItemRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyComboItemRenderer.h"
#import "OptionSectionHeaderView.h"
#import "ExpandableCellData.h"
#import "Item.h"

@implementation ShinyComboItemRenderer
-(id)initWithItem:(Item *)anItem
{
    self = [super init];
    
    if(self)
    {
        
        theItem = anItem;
        
        sectionNames = [[NSMutableArray alloc] init];
        listData = [[NSMutableArray alloc] init];
        
        [sectionNames addObject:@"Options"];
        NSMutableArray *optionSectionContents = [[NSMutableArray alloc] init];
        
        [optionSectionContents addObject:[OptionSectionHeaderView new]];
        
        NSMutableDictionary *favoriteCell = [[NSMutableDictionary alloc] init];
        [favoriteCell setValue:theItem forKey:@"favoriteCellItem"];
        [optionSectionContents addObject:favoriteCell];
      
        for (Option *eachOption in [theItem options]) {
            ExpandableCellData *optionCellData = [[ExpandableCellData alloc] initWithPrimaryItem:eachOption AndRenderer:self];
            [optionSectionContents addObject:optionCellData];
            [optionSectionContents addObjectsFromArray:[optionCellData expansionContents]];
            [optionCellData setIsOpen:YES];
            
        }  
        
        [listData addObject:optionSectionContents];
        
    }
    
    return self;
}
@end
