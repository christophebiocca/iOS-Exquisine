//
//  ItemMenuCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuCompositeCell.h"

@class Item;

@interface ItemMenuCell : MenuCompositeCell
{
    Item* item;
}

+(NSString*)cellIdentifier;

-(void)setData:(id)theItem;

@end
