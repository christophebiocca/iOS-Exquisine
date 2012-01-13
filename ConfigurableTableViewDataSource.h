//
//  ConfigurableTableViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellInfo.h"

@interface ConfigurableTableViewDataSource : NSObject<UITableViewDataSource, UITableViewDelegate>{
    
    NSMutableArray *displayList;
    
}

@property (retain) NSMutableArray *displayList;

@end
