//
//  ItemRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponentRenderer.h"
@class Item;

@interface ItemRenderer : MenuComponentRenderer <UITableViewDataSource>

-(ItemRenderer *) initWithItem:(Item *) anItem;

@end
