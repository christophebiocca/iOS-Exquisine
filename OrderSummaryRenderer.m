//
//  OrderSummaryRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderSummaryRenderer.h"
#import "GeneralPurposeViewCellData.h"
#import "Combo.h"
#import "ComboRenderer.h"
#import "Order.h"
#import "Option.h"
#import "Choice.h"
#import "Item.h"
#import "ItemGroup.h"
#import "ItemRenderer.h"
#import "Utilities.h"

@implementation OrderSummaryRenderer

-(OrderSummaryRenderer *)initWithOrder:(Order *)anOrder
{
    self = [super init];

    if (self) {
        //It's not pretty, but I cant think of a less messy way of doing it at the moment.
        context = CELL_CONTEXT_RECEIPT;
        sectionNames = [[NSMutableArray alloc] initWithObjects:@"Reciept", nil];
                
        UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
        UIFont *descFont = [UIFont fontWithName:@"HelveticaNeue" size:13];
        
        NSMutableArray *displayList = [[NSMutableArray alloc] initWithCapacity:0];
            
        GeneralPurposeViewCellData *newCellData;
        
        for (Combo *eachCombo in [anOrder comboList]) {
            
            newCellData = [[GeneralPurposeViewCellData alloc] init];
            [newCellData setTitle:[eachCombo name]];
            [newCellData setDescription:[Utilities FormatToPrice:[eachCombo price]]];
            [newCellData setTitleFont:titleFont];
            [newCellData setDescriptionFont:descFont];
            [displayList addObject:newCellData];
            
            for (ItemGroup *eachItemGroup in [eachCombo listOfItemGroups]) {
                newCellData = [[GeneralPurposeViewCellData alloc] init];
                [newCellData setTitle:[[eachItemGroup satisfyingItem] name]];
                [newCellData setTitleFont:titleFont];
                [newCellData setIndent:1];
                [displayList addObject:newCellData];
                
                for (Option *eachOption in [[eachItemGroup satisfyingItem] options]) {
                    if ([eachOption numberOfSelectedChoices] > 0) {
                        newCellData = [[GeneralPurposeViewCellData alloc] init];
                        [newCellData setTitle:[eachOption name]];
                        [newCellData setTitleFont:titleFont];
                        [newCellData setIndent:2];
                        [displayList addObject:newCellData];
                        
                        for (Choice *eachChoice in [eachOption selectedChoices]) {
                            newCellData = [[GeneralPurposeViewCellData alloc] init];
                            [newCellData setTitle:[eachChoice name]];
                            [newCellData setTitleFont:titleFont];
                            [newCellData setIndent:3];
                            [displayList addObject:newCellData];
                        }
                    }
                }
            }
        }
        
        for (Item *eachItem in [anOrder itemList]) {
            newCellData = [[GeneralPurposeViewCellData alloc] init];
            [newCellData setTitle:[eachItem name]];
            [newCellData setDescription:[Utilities FormatToPrice:[eachItem price]]];
            [newCellData setTitleFont:titleFont];
            [newCellData setDescriptionFont:descFont];
            [newCellData setIndent:0];
            [displayList addObject:newCellData];
            
            for (Option *eachOption in [eachItem options]) {
                if ([eachOption numberOfSelectedChoices] > 0) {
                    newCellData = [[GeneralPurposeViewCellData alloc] init];
                    [newCellData setTitle:[eachOption name]];
                    [newCellData setTitleFont:titleFont];
                    [newCellData setIndent:1];
                    [displayList addObject:newCellData];
                    
                    for (Choice *eachChoice in [eachOption selectedChoices]) {
                        newCellData = [[GeneralPurposeViewCellData alloc] init];
                        [newCellData setTitle:[eachChoice name]];
                        [newCellData setTitleFont:titleFont];
                        [newCellData setIndent:2];
                        [displayList addObject:newCellData];
                    }
                }
            }
        }
        
        newCellData = [[GeneralPurposeViewCellData alloc] init];
        [newCellData setTitle:@"Subtotal:"];
        [newCellData setDescription:[Utilities FormatToPrice:[anOrder subtotalPrice]]];
        [newCellData setTitleFont:titleFont];
        [newCellData setDescriptionFont:descFont];
        [displayList addObject:newCellData];
        
        newCellData = [[GeneralPurposeViewCellData alloc] init];
        [newCellData setTitle:@"HST:"];
        [newCellData setDescription:[Utilities FormatToPrice:[anOrder taxPrice]]];
        [newCellData setTitleFont:titleFont];
        [newCellData setDescriptionFont:descFont];
        [displayList addObject:newCellData];
        
        newCellData = [[GeneralPurposeViewCellData alloc] init];
        [newCellData setTitle:@"Total:"];
        [newCellData setDescription:[Utilities FormatToPrice:[anOrder totalPrice]]];
        [newCellData setTitleFont:titleFont];
        [newCellData setDescriptionFont:descFont];
        [displayList addObject:newCellData];
        
        listData = [[NSMutableArray alloc] initWithObjects:displayList, nil];
    }
    
    return self;
}

@end
