//
//  VisualizableData.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define allowOverride 1


#import <UIKit/UIKit.h>

@class MenuComponent;

@interface VisualizableData : UIViewController{
    id dataOwner;
}

@property(readonly)id dataOwner;

-(id)initWithOwner:(id)owner;

@end
