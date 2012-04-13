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

@interface SettingsTabViewController : UIViewController<UITableViewDelegate,UINavigationControllerDelegate>
{
    SettingsTabView *settingsTabView;
    ShinySettingsTabRenderer *settingsTabRenderer;
    
    /* Animation Management */
    BOOL animating;
    NSMutableArray* postAnimation;
    id<UINavigationControllerDelegate> oldDelegate;
}

@end
