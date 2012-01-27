//
//  MenuComponentRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Renderer.h"
@class MenuComponent;
@class MenuComponentView;
@class CellData;

@interface MenuComponentRenderer : Renderer
{
    MenuComponent *menuComponent;
}

-(MenuComponentRenderer *) initWithMenuComponent:(MenuComponent *) aMenuComponent;

-(UITableViewCell *) configureCell:(UITableViewCell *) aCell;

-(CellData *) detailedStaticRenderDefaultCell;

@end
