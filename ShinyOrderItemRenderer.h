//
//  ShinyOrderItemRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListRenderer.h"
@class Item;

@interface ShinyOrderItemRenderer : ListRenderer
{
    Item *theItem;
}

-(id) initWithItem:(Item *) anItem;


@end
