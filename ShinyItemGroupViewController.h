//
//  ShinyItemGroupViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewController.h"
@class ItemGroup;

@interface ShinyItemGroupViewController : ListViewController
{
    ItemGroup *theItemGroup;
}

@property (retain) ItemGroup *theItemGroup;

-(id) initWithItemGroup:(ItemGroup *) anItemGroup;

@end
