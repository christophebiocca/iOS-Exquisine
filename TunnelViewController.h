//
//  TunnelViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// A tunnel view controller is initialized with a list of view controllers that will
// be represented in a "tunnel". Special cases occur at either end of the tunnel, but the
// controllers that are being managed needn't know this. They will just be responsible for
// sending forward and backward signals. 

// If the user tries to move back out of the tunnel, the delegate will be asked to define 
// a function to deal with it. 

// Similarly, after the end of the tunnel is reached, a delegate function 
// will be called to deal with what needs to happen next.

// The goForwards and goBackwards delegate functions have a "contextInformation" field.
// This is just in case there is more information necessary for the delegate to
// figure out what to do. In the case of a TunnelViewController, there wont be.

#import <UIKit/UIKit.h>
#import "LargeScopeControllerDelegate.h"
#import "TunnelViewControllerDelegate.h"

@interface TunnelViewController: NSObject <LargeScopeControllerDelegate,UINavigationControllerDelegate>
{
    
    UINavigationController *navController;
    
    NSArray *controllerTunnelList;
    
    NSInteger currentListIndexCursor;
    
    id<TunnelViewControllerDelegate> tunnelDelegate;

}

@property (retain) id<TunnelViewControllerDelegate> tunnelDelegate;
@property (retain, readonly) UINavigationController* navController;

-(TunnelViewController *) initWithTunnelList:(NSArray *) controllerList;

@end
