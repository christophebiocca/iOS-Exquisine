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


@interface OptionViewController  :MenuComponentViewController <UITableViewDelegate>
{
    
    UIBarButtonItem *forwardButton;
    Option *optionInfo;
    OptionView *optionView;
    OptionRenderer *optionRenderer;
    BOOL tunnelVersion;
    
}

@property (retain) Option *optionInfo;

-(OptionViewController *) initializeWithOption:(Option *) anOption;

-(void) forwardButtonClicked;

@end
