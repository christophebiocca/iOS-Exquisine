//
//  ShinyItemRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListRenderer.h"
@class Item;

@interface ShinyItemRenderer : ListRenderer
{
    Item *theItem;
}

-(id) initWithItem:(Item *) anItem;

@end
