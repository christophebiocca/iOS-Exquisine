//
//  ShinyItemViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Item;
@class ShinyItemView;
@class ShinyItemRenderer;


@interface ShinyItemViewController : UIViewController <UITableViewDelegate>
{
    Item *theItem;
    ShinyItemView *itemView;
    ShinyItemRenderer *itemRenderer;
    
}

-(id) initWithItem:(Item *) anItem;

@end
