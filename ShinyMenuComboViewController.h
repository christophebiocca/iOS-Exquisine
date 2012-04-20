//
//  ShinyComboViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewController.h"
@class Combo;

extern NSString* COMBO_DONE_BUTTON_HIT;

@interface ShinyMenuComboViewController : ListViewController
{
    Combo *theCombo;
}

@property (retain) Combo *theCombo;

-(id) initWithCombo:(Combo *) aCombo;

@end
