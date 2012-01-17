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
    MenuComponent* dataOwner;
}

@property(readonly)MenuComponent* dataOwner;

-(id)initWithOwner:(MenuComponent*)owner;

@end
