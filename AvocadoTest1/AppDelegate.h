//
//  AppDelegate.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainPageViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UINavigationController* navigationController;
    MainPageViewController* page;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController* navigationController;

@end
