//
//  SettingsViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingsView;
@class SettingsRenderer;
@class LocationState;

@interface SettingsViewController : UITableViewController <UITableViewDelegate>
{
    LocationState *theLocationState;
    SettingsView *settingsView;
    SettingsRenderer *settingsRenderer;
}

-(id) initWithLocationState:(LocationState *)locationState;

@end
