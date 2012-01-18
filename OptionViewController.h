//
//  OptionViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponentViewController.h"
@class Option;
@class OptionView;
@class OptionRenderer;


@interface OptionViewController  :UITableViewController <UITableViewDelegate>
{
    
    Option *optionInfo;
    OptionView *optionView;
    OptionRenderer *optionRenderer;
    
}

@property (retain) Option *optionInfo;

-(OptionViewController *) initializeWithOption:(Option *) anOption;

@end
