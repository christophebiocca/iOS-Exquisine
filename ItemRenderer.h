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

    //This guy contains stuff that we need
    //to display cells for after the item list.
    NSMutableArray *suffixList;
    
    //This actually expects a list of lists such that the members of the internal lists
    //respond to configureCell. Do not break this contract!
    NSMutableArray *displayLists;
    
    NSMutableArray *optionRenderList;
}

@property (retain) Item *itemInfo;

-(void) redraw;

-(ItemRenderer *) initWithItem:(Item *) anItem;

-(UITableViewCell *) configureCell:(UITableViewCell *) aCell;

@end
