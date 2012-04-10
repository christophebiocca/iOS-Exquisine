//
//  ShinyOrderComboRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyOrderComboRenderer.h"
#import "NumberOfCombosView.h"
#import "IntegerInputCellData.h"
#import "Combo.h"
#import "ItemGroupSectionHeaderView.h"

@implementation ShinyOrderComboRenderer
-(id)initWithCombo:(Combo *)aCombo
{
    self = [super init];
    
    if(self)
    {
        theCombo = aCombo;
        
        sectionNames = [[NSMutableArray alloc] init];
        listData = [[NSMutableArray alloc] init];
        
        [sectionNames addObject:@"Combo Quantity"];
        NSMutableArray *numberOfCombosSectionContents = [[NSMutableArray alloc] init];
        
        [numberOfCombosSectionContents addObject:[NumberOfCombosView new]];
        IntegerInputCellData *newCell = [[IntegerInputCellData alloc] init];
        [newCell setNumber:[theCombo numberOfCombos]];
        [newCell setLowerBound:[NSNumber numberWithInt:1]];
        [newCell setUpperBound:[NSNumber numberWithInt:100]];
        [numberOfCombosSectionContents addObject:newCell];
        
        [listData addObject:numberOfCombosSectionContents];
        
        [sectionNames addObject:@"Item Groups"];
        NSMutableArray *itemGroupSectionContents = [[NSMutableArray alloc] init];
        
        if ([[theCombo listOfItemGroups] count] != 0) {
            
            [itemGroupSectionContents addObject:[ItemGroupSectionHeaderView new]];
            
        }
        
        NSMutableDictionary *favoriteCell = [[NSMutableDictionary alloc] init];
        [favoriteCell setValue:theCombo forKey:@"favoriteCellCombo"];
        [itemGroupSectionContents addObject:favoriteCell];
        
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
        
        [deleteButton setTitle:@"Delete Combo" forState:UIControlStateNormal];
        
        [deleteButton setFrame:CGRectMake(0, 0, 300, 42)];
        
        [itemGroupSectionContents addObject:deleteButton];
        
        if ([[theCombo listOfItemGroups] count] != 0) {
            [itemGroupSectionContents addObjectsFromArray:[theCombo listOfItemGroups]];
        }

        [listData addObject:itemGroupSectionContents];
        
    }
    
    return self;
}
@end
