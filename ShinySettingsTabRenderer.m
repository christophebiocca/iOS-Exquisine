//
//  ShinySettingsTabRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinySettingsTabRenderer.h"
#import "ShinyHeaderView.h"

@implementation ShinySettingsTabRenderer

-(id)init
{
    self = [super init];
    
    if(self)
    {
        sectionNames = [[NSMutableArray alloc] init];
        listData = [[NSMutableArray alloc] init];
        
        [sectionNames addObject:@"ListOfSettings"];
        NSMutableArray *listOfSettingsSectionContents = [[NSMutableArray alloc] init];
        
        [listOfSettingsSectionContents addObject:[[ShinyHeaderView alloc] initWithTitle:@"Settings"]];
        [listOfSettingsSectionContents addObject:[NSDictionary dictionaryWithObject:@"Credit Card" forKey:@"settingTitle"]];
        [listOfSettingsSectionContents addObject:[NSDictionary dictionaryWithObject:@"Order History" forKey:@"settingTitle"]];
        
        [listOfSettingsSectionContents addObject:[[ShinyHeaderView alloc] initWithTitle:@"Support"]];
        UILabel *techSupportLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 320, 150)];
        [techSupportLabel setFont:[UIFont fontWithName:@"AmericanTypewriter" size:14]];
        [techSupportLabel setNumberOfLines:70];
        [techSupportLabel setText:@"If you have any questions or comments,\nfeel free to call us at:\n(519) 616-6193 \nor email us at:\ndev@croutonlabs.com\n\nYou can also visit our website at:\ncroutonlabs.com"];
        [techSupportLabel setLineBreakMode:UILineBreakModeWordWrap];
        [techSupportLabel setTextAlignment:UITextAlignmentLeft];
        
        [listOfSettingsSectionContents addObject:techSupportLabel];
        
        [listData addObject:listOfSettingsSectionContents];
        
    }
    
    return self;
}

@end
