//
//  OptionPage.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Option;
@class OptionPageView;
@class ConfigurableTableViewDataSource;

@interface OptionPage : UIViewController<UITableViewDelegate>{
    
    ConfigurableTableViewDataSource *optionTableDataSource;
    OptionPageView *optionPageView;
    Option *currentOption;
    
}

@property (retain) Option *currentOption;

-(void)initializeViewWithOption:(Option *) anOption;

@end
