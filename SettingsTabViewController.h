//
//  SettingsTabViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingsTabView;
@class ShinySettingsTabRenderer;

@interface SettingsTabViewController : UIViewController<UITableViewDelegate>
{
    SettingsTabView *settingsTabView;
    ShinySettingsTabRenderer *settingsTabRenderer;
}

@end
