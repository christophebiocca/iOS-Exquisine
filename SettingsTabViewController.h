//
//  SettingsTabViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewController.h"
@class SettingsTabView;
@class ShinySettingsTabRenderer;

@interface SettingsTabViewController : ListViewController<UINavigationControllerDelegate>
{
    /* Animation Management */
    BOOL animating;
    NSMutableArray* postAnimation;
    id<UINavigationControllerDelegate> oldDelegate;
}

@end
