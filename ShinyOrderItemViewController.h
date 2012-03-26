//
//  ShinyOrderItemViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Item;
@class ShinyItemView;
@class ShinyOrderItemRenderer;

extern NSString* ITEM_DELETE_BUTTON_HIT;

@interface ShinyOrderItemViewController : UIViewController <UITableViewDelegate>
{
    Item *theItem;
    ShinyItemView *itemView;
    ShinyOrderItemRenderer *itemRenderer;
    
}

@property (retain) Item *theItem;

-(id) initWithItem:(Item *) anItem;

@end
