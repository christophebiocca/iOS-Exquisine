//
//  MenuComponentViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TunnelViewControllerDelegate.h"
#import "LargeScopeControllerDelegate.h"

@interface MenuComponentViewController : UIViewController
{
      id<LargeScopeControllerDelegate> superviewDelegate;
}

@property (retain) id<LargeScopeControllerDelegate> superviewDelegate;

@end
