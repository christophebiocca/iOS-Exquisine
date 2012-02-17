//
//  MenuComponentRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListRenderer.h"

@class MenuComponent;
@class MenuComponentView;
@class CellData;

@interface MenuComponentRenderer : ListRenderer
{
    
}

+(MenuComponentRenderer *) menuComponentRendererFromData:(id) data;

@end
