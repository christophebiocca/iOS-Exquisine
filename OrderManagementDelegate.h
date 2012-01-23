//
//  OrderManagementDelegate.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OrderViewController;

@protocol OrderManagementDelegate <NSObject>

-(void) submitOrderForController:(OrderViewController *)orderViewController;
-(void) addToFavoritesForController:(OrderViewController *)orderViewController;

@end
