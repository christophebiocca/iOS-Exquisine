//
//  ComboMenuCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuCompositeCell.h"
@class Combo;

@interface ComboMenuCell : MenuCompositeCell
{
    Combo *combo;
}

-(void)setMenuComponent:(Combo*)theCombo;

@end
