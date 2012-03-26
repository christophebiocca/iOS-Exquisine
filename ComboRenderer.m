//
//  ComboRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComboRenderer.h"
#import "Order.h"
#import "Combo.h"
#import "ItemRenderer.h"
#import "ItemGroup.h"
#import "IntegerInputCellData.h"

@implementation ComboRenderer

-(ComboRenderer *)initWithCombo:(Combo *)aCombo
{
    self = [super init];
    
    if(self)
    {
        [sectionNames addObject:@"Number of combos"];
        IntegerInputCellData *inputCellData = [[IntegerInputCellData alloc] init];
        [inputCellData setNumber:[aCombo numberOfCombos]];
        [inputCellData setLowerBound:[NSNumber numberWithInt:1]];
        [inputCellData setUpperBound:[NSNumber numberWithInt:100]];
        [listData addObject:[NSArray arrayWithObject:inputCellData]];
        
        [sectionNames addObject:[aCombo name]];
        [listData addObject:[aCombo listOfItemGroups]];
    }
    
    return self;
}


@end
