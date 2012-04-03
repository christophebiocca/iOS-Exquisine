//
//  ShinyComboRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListRenderer.h"
@class Combo;

@interface ShinyComboRenderer : ListRenderer
{
    Combo *theCombo;
}

-(id) initWithCombo:(Combo *) aCombo;

@end