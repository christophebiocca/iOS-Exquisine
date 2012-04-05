//
//  ShinyItemGroupRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListRenderer.h"
@class ItemGroup;

@interface ShinyItemGroupRenderer : ListRenderer
{
    ItemGroup *theItemGroup;
}

-(id) initWithItemGroup:(ItemGroup *) anItemGroup;

@end
