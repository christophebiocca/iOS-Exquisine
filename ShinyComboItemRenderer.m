//
//  ShinyComboItemRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyComboItemRenderer.h"
#import "ShinyHeaderView.h"
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
        
        if (![[theItem desc] isEqualToString:@""]) {
            NSMutableArray *descSection = [[NSMutableArray alloc] init];
            [sectionNames addObject:@"Description"];
            
            [descSection addObject:[[ShinyHeaderView alloc] initWithTitle:@"Description"]];
            
            //Add a spacer
            [descSection addObject:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)]];
            
            UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 200)];
            [descriptionLabel setFont:[Utilities fravicLargeTextFont]];
            [descriptionLabel setLineBreakMode:UILineBreakModeWordWrap];
            [descriptionLabel setNumberOfLines:0];
            
            CGSize maximumLabelSize = CGSizeMake(296,9999);
            
            CGSize expectedLabelSize = [[theItem desc] sizeWithFont:descriptionLabel.font 
                                                  constrainedToSize:maximumLabelSize 
                                                      lineBreakMode:descriptionLabel.lineBreakMode]; 
            //adjust the label the the new height.
            CGRect newFrame = descriptionLabel.frame;
            newFrame.size.height = expectedLabelSize.height;
            descriptionLabel.frame = newFrame;
            [descriptionLabel setText:[theItem desc]];
            [descSection addObject:descriptionLabel];
            
            [listData addObject:descSection];
        }
        
        [sectionNames addObject:@"Options"];
        NSMutableArray *optionSectionContents = [[NSMutableArray alloc] init];
        
        [optionSectionContents addObject:[[ShinyHeaderView alloc] initWithTitle:@"Options"]];
        
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
