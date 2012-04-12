//
//  OrderSummaryPageRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderSummaryPageRenderer.h"
#import "GeneralPurposeViewCellData.h"
#import "ShinyHeaderView.h"
#import "ItemGroup.h"
#import "Combo.h"
#import "Order.h"

@implementation OrderSummaryPageRenderer

-(id)initWithOrder:(Order *)anOrder
{
    self = [super init];
    
    if(self)
    {
        theOrder = anOrder;
        //This is intentionally a 1.
        int index = 1;
        NSMutableArray *orderSectionContents = [[NSMutableArray alloc] initWithCapacity:0];
        
        [orderSectionContents addObject:[[ShinyHeaderView alloc] initWithTitle:@"Receipt"]];
        
        UIView *spaceFiller = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
        [spaceFiller setBackgroundColor:[UIColor clearColor]];
        
        [orderSectionContents addObject:spaceFiller];
        
        GeneralPurposeViewCellData *submitTimeCell = [[GeneralPurposeViewCellData alloc] init];
        [submitTimeCell setTitle:@"Submit Time:"];
        [submitTimeCell setHeight:22.0f];
        
        if (index%2) 
            [submitTimeCell setCellColour:[Utilities fravicDarkPinkColor]];
        else 
            [submitTimeCell setCellColour:[Utilities fravicLightPinkColor]];
        
        [submitTimeCell setDescription:[Utilities FormatToDate:[theOrder mostRecentSubmitDate]]];
        [orderSectionContents addObject:submitTimeCell];
        index++;
        
        
        GeneralPurposeViewCellData *pickupTimeCell = [[GeneralPurposeViewCellData alloc] init];
        [pickupTimeCell setTitle:@"Pickup Time:"];
        [pickupTimeCell setHeight:22.0f];
        
        if (index%2) 
            [pickupTimeCell setCellColour:[Utilities fravicDarkPinkColor]];
        else 
            [pickupTimeCell setCellColour:[Utilities fravicLightPinkColor]];
        
        [pickupTimeCell setDescription:[Utilities FormatToDate:[theOrder pitaFinishedTime]]];
        [orderSectionContents addObject:pickupTimeCell];
        index++;
        
        
        for (Combo *eachCombo in [theOrder comboList]) {
            NSMutableDictionary *newDictionary = [[NSMutableDictionary alloc] init];
            
            [newDictionary setObject:eachCombo forKey:@"combo"];
            [newDictionary setObject:[NSNumber numberWithInt:index] forKey:@"index"];
            [orderSectionContents addObject:newDictionary];
            index++;
            
            for (ItemGroup *eachItemGroup in [eachCombo listOfItemGroups]) {
                NSMutableDictionary *anotherDictionary = [[NSMutableDictionary alloc] init];
                Item *anItem = [eachItemGroup satisfyingItem];
                [anotherDictionary setObject:anItem forKey:@"orderComboItem"];
                [anotherDictionary setObject:[NSNumber numberWithInt:index] forKey:@"index"];
                [anotherDictionary setObject:@"orderCombo" forKey:@"context"];
                [orderSectionContents addObject:anotherDictionary];
                index++;
            }
            
        }
        
        for (Item *anItem in [theOrder itemList]) {
            NSMutableDictionary *anotherDictionary = [[NSMutableDictionary alloc] init];
            [anotherDictionary setObject:anItem forKey:@"orderItem"];
            [anotherDictionary setObject:[NSNumber numberWithInt:index] forKey:@"index"];
            [anotherDictionary setObject:@"order" forKey:@"context"];
            [orderSectionContents addObject:anotherDictionary];
            index++;
        }
        
        GeneralPurposeViewCellData *subtotalCell = [[GeneralPurposeViewCellData alloc] init];
        [subtotalCell setTitle:@"Subtotal:"];
        [subtotalCell setHeight:22.0f];
        
        if (index%2) 
            [subtotalCell setCellColour:[Utilities fravicDarkPinkColor]];
        else 
            [subtotalCell setCellColour:[Utilities fravicLightPinkColor]];
        
        [subtotalCell setDescription:[Utilities FormatToPrice:[theOrder subtotalPrice]]];
        [orderSectionContents addObject:subtotalCell];
        index++;
        
        GeneralPurposeViewCellData *hstCell = [[GeneralPurposeViewCellData alloc] init];
        [hstCell setTitle:@"HST:"];
        [hstCell setHeight:22.0f];
        
        if (index%2) 
            [hstCell setCellColour:[Utilities fravicDarkPinkColor]];
        else 
            [hstCell setCellColour:[Utilities fravicLightPinkColor]];
        
        [hstCell setDescription:[Utilities FormatToPrice:[theOrder taxPrice]]];
        [orderSectionContents addObject:hstCell];
        index++;
        
        GeneralPurposeViewCellData *grandTotalCell = [[GeneralPurposeViewCellData alloc] init];
        [grandTotalCell setTitle:@"Grand Total:"];
        [grandTotalCell setHeight:22.0f];
        
        if (index%2) 
            [grandTotalCell setCellColour:[Utilities fravicDarkPinkColor]];
        else 
            [grandTotalCell setCellColour:[Utilities fravicLightPinkColor]];
        
        [grandTotalCell setDescription:[Utilities FormatToPrice:[theOrder totalPrice]]];
        [orderSectionContents addObject:grandTotalCell];
        index++;
        
        [listData addObject:orderSectionContents];
        
    }
    
    return self;
}

@end
