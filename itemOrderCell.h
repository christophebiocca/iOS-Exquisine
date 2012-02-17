//
//  itemOrderCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MenuCompositeCell.h"

@class Item;

@interface ItemOrderCell : MenuCompositeCell
{
    Item* item;
}

@property(nonatomic,retain)Item* item;

+(NSString*)cellIdentifier;

@end
