//
//  ShinyItemGroupViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShinyItemGroupView;
@class ShinyItemGroupRenderer;
@class ItemGroup;

@interface ShinyItemGroupViewController : UIViewController<UITableViewDelegate>
{
    ItemGroup *theItemGroup;
    ShinyItemGroupView *itemGroupView;
    ShinyItemGroupRenderer *itemGroupRenderer;
    
}

@property (retain) ItemGroup *theItemGroup;

-(id) initWithItemGroup:(ItemGroup *) anItemGroup;


@end
