//
//  ItemManagementDelegate.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-08.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ItemViewController;

@protocol ItemManagementDelegate <NSObject>

-(void) addItemForController:(ItemViewController *)itemViewcontroller;

@end
