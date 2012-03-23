//
//  MasterViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MasterView;
@class AppData;

@interface MasterViewController : UIViewController
{
    MasterView *masterView;
    AppData *appData;
}

@property (retain) MasterView *masterView;
@property (retain) AppData *appData;

- (id) initWithFrame:(CGRect)frame;

- (void) reloadData;

@end
