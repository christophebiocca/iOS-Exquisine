//
//  ShinyComboViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Combo;
@class ShinyComboView;
@class ShinyMenuComboRenderer;

extern NSString* COMBO_DONE_BUTTON_HIT;

@interface ShinyMenuComboViewController : UIViewController<UITableViewDelegate>
{
    Combo *theCombo;
    ShinyComboView *comboView;
    ShinyMenuComboRenderer *comboRenderer;
    
}

@property (retain) Combo *theCombo;

-(id) initWithCombo:(Combo *) aCombo;

@end
