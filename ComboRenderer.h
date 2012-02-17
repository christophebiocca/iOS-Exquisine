//
//  ComboRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponentRenderer.h"
@class Order;
@class Combo;
@interface ComboRenderer : MenuComponentRenderer 

-(ComboRenderer *) initWithCombo: (Combo *) aCombo;

@end
