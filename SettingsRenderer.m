//
//  SettingsRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsRenderer.h"
#import "GeneralPurposeViewCellData.h"

@implementation SettingsRenderer

-(id)init
{
    self = [super init];
    
    if(self)
    {
        listData = [[NSMutableArray alloc] initWithCapacity:0];
        sectionNames = [[NSMutableArray alloc] initWithCapacity:0];
        
        NSMutableArray *settingsSection1 = [[NSMutableArray alloc] initWithCapacity:0];
        
        GeneralPurposeViewCellData *data = nil;
        
        data = [[GeneralPurposeViewCellData alloc] init];
        [data setTitle:@"Set Location"];
        [settingsSection1 addObject:data];
        
        data = [[GeneralPurposeViewCellData alloc] init];
        [data setTitle:@"Payment Information"];
        [settingsSection1 addObject:data];
        
        [listData addObject:settingsSection1];
        [sectionNames addObject:@"Settings"];
        
        //[data setTitleFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:13]];
        
    }
    
    return self;
}

@end
