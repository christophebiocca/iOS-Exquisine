//
//  ShinyOrderTabRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListRenderer.h"
@class OrderManager;

@interface ShinyOrderTabRenderer : ListRenderer
{
    OrderManager *theOrderManager;
}

-(id) initWithOrderManager:(OrderManager *) anOrderManager;

@end
