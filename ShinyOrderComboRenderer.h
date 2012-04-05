//
//  ShinyOrderComboRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListRenderer.h"
@class Combo;

@interface ShinyOrderComboRenderer : ListRenderer
{
    Combo *theCombo;
}

-(id) initWithCombo:(Combo *) aCombo;



@end
