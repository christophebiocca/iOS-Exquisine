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
{
    
    Item *itemInfo;
    
}

@property (retain) Item *itemInfo;

-(ItemRenderer *) initWithItem:(Item *) anItem;

-(NSArray *) detailedStaticRenderList;

@end
