//
//  ItemGroupRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-01.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponentRenderer.h"
@class ItemGroup;

@interface ItemGroupRenderer : MenuComponentRenderer<UITableViewDataSource>

-(ItemGroupRenderer *) initWithItemGroup:(ItemGroup *) anItemGroup;

@end
