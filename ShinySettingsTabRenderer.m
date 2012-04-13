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
        UILabel *techSupportLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 320, 30)];
        [techSupportLabel setFont:[UIFont fontWithName:@"AmericanTypewriter" size:14]];
        [techSupportLabel setNumberOfLines:70];
        [techSupportLabel setText:@"If you have any questions or comments,\nfeel free to call us at:"];
        [techSupportLabel setLineBreakMode:UILineBreakModeWordWrap];
        [listOfSettingsSectionContents addObject:techSupportLabel];
        
        [listOfSettingsSectionContents addObject:[NSDictionary dictionaryWithObject:@"519-616-6193" forKey:@"telephoneNumber"]];
        UILabel *secondTechSupportLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 320, 9)];
        [secondTechSupportLabel setFont:[UIFont fontWithName:@"AmericanTypewriter" size:14]];
        [secondTechSupportLabel setNumberOfLines:70];
        [secondTechSupportLabel setText:@"or email us at:"];
        [secondTechSupportLabel setLineBreakMode:UILineBreakModeWordWrap];
        [listOfSettingsSectionContents addObject:secondTechSupportLabel];
        
        [listOfSettingsSectionContents addObject:[NSDictionary dictionaryWithObject:@"support@croutonlabs.com" forKey:@"emailAddress"]];
        
        [listData addObject:listOfSettingsSectionContents];
        
    }
    
    return self;
}

@end
