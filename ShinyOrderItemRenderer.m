//
//  ShinyOrderItemRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyOrderItemRenderer.h"
#import "OptionSectionHeaderView.h"
#import "NumberOfItemsSectionHeaderView.h"
#import "IntegerInputCellData.h"
#import "ExpandableCellData.h"
#import "Option.h"
#import "Item.h"

@implementation ShinyOrderItemRenderer

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
        
        for (Option *eachOption in [theItem options]) {
            ExpandableCellData *optionCellData = [[ExpandableCellData alloc] initWithPrimaryItem:eachOption AndRenderer:self];
            [optionSectionContents addObject:optionCellData];
            [optionSectionContents addObjectsFromArray:[optionCellData expansionContents]];
            [optionCellData setIsOpen:YES];
        }
        
        //It's a bit hackish they we're adding the button in here in stead of in it's own section
        //but I don't think it will cause problems.
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [deleteButton setBackgroundImage:[[UIImage imageNamed:@"DeleteButtonImage.png"]
                                          stretchableImageWithLeftCapWidth:8.0f
                                          topCapHeight:0.0f]
                                forState:UIControlStateNormal];
        
        [deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        deleteButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        deleteButton.titleLabel.shadowColor = [UIColor lightGrayColor];
        deleteButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
        
        [deleteButton setTitle:@"Delete Item" forState:UIControlStateNormal];
        
        [deleteButton setFrame:CGRectMake(0, 0, 300, 42)];
        
        [optionSectionContents addObject:deleteButton];
        
        [listData addObject:optionSectionContents];
    }
    
    return self;
}

@end