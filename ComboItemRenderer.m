//
//  ComboItemRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComboItemRenderer.h"

@implementation ComboItemRenderer
-(ItemRenderer *)initWithItem:(Item *)anItem
{
    self = [super initWithItem:anItem];
    
    if (self) {
        [listData removeObjectAtIndex:0];
        [sectionNames removeObjectAtIndex:0];
    }
    
    return self;
}
@end
