//
//  LargeScopeControllerDelegate.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LargeScopeControllerDelegate <NSObject>

-(void) signalForwards:(UIViewController *) requester WithContext: (NSArray *) contextInformation;

-(void) signalBackwards:(UIViewController *) requester WithContext: (NSArray *) contextInformation;

@end
