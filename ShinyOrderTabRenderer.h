//
//  ShinyOrderTabRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListRenderer.h"
@class Order;

@interface ShinyOrderTabRenderer : ListRenderer
{
    Order *theOrder;
}

-(id) initWithOrder:(Order *) anOrder;

@end
