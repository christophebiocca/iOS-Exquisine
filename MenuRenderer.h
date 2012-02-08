//
//  MenuRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponentRenderer.h"
@class Menu;

@interface MenuRenderer : MenuComponentRenderer<UITableViewDataSource>
{
    
    Menu *menuInfo;
    
}

-(MenuRenderer *) initWithMenu:(Menu *) aMenu;

@end
