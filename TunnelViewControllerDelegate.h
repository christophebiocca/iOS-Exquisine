//
//  TunnelViewControllerDelegate.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TunnelViewController;

@protocol TunnelViewControllerDelegate <NSObject>

-(void) firstControllerBeingPopped:(TunnelViewController *) tunnelController;

-(void) lastControllerBeingPushedPast:(TunnelViewController *) tunnelController;

@end
