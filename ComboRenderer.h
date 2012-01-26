//
//  ComboRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Renderer.h"
@class Order;
@class Combo;
@interface ComboRenderer : Renderer
{
    Combo *currentCombo;
}

-(ComboRenderer *) initFromCombo: (Combo *) aCombo;

-(NSMutableArray *) produceRenderList;

@end
