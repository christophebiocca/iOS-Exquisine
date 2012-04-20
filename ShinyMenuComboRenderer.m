//
//  ShinyComboRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyMenuComboRenderer.h"
#import "ExpandableCellData.h"
#import "Combo.h"
#import "IntegerInputCellData.h"
#import "ShinyHeaderView.h"
#import "ItemGroup.h"

@implementation ShinyMenuComboRenderer


-(id)initWithCombo:(Combo *)aCombo
{
    self = [super init];
    
    if(self)
    {
        theCombo = aCombo;
        
        sectionNames = [[NSMutableArray alloc] init];
        listData = [[NSMutableArray alloc] init];
        
        [sectionNames addObject:@"Number of Combos"];
        NSMutableArray *quantitySection = [[NSMutableArray alloc] init];
        
        [quantitySection addObject:[[ShinyHeaderView alloc] initWithTitle:@"Quantity"]];
        
        IntegerInputCellData *newCell = [[IntegerInputCellData alloc] init];
        [newCell setNumber:[theCombo numberOfCombos]];
        [newCell setLowerBound:[NSNumber numberWithInt:1]];
        [newCell setUpperBound:[NSNumber numberWithInt:100]];
        [quantitySection addObject:newCell];
        
        [listData addObject:quantitySection];
        
        
        [sectionNames addObject:@"Item Groups"];
        NSMutableArray *itemGroupSectionContents = [[NSMutableArray alloc] init];
        
        [itemGroupSectionContents addObject:[[ShinyHeaderView alloc] initWithTitle:@"Components"]];
        
        NSMutableDictionary *favoriteCell = [[NSMutableDictionary alloc] init];
        [favoriteCell setValue:theCombo forKey:@"favoriteCellCombo"];
        [itemGroupSectionContents addObject:favoriteCell];
   
        [itemGroupSectionContents addObjectsFromArray:[theCombo listOfItemGroups]];
        
        [listData addObject:itemGroupSectionContents];
        
    }
    
    return self;
}


@end
