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
@class ShinyMenuItemRenderer;

extern NSString* ITEM_DONE_BUTTON_HIT;

@interface ShinyMenuItemViewController : UIViewController <UITableViewDelegate>
{
    Item *theItem;
    ShinyItemView *itemView;
    ShinyMenuItemRenderer *itemRenderer;
    
}

@property (retain) Item *theItem;

-(id) initWithItem:(Item *) anItem;

@end
