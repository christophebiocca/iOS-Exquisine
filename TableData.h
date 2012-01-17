//
//  TableData.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VisualizableData.h"

@interface TableData : VisualizableData<UITableViewDataSource, UITableViewDelegate>{
    
    // by default, this will be displayed as the title for the navigation 
    // controller passed to the TableData instance.
    NSString *tableName;
    
    // Every member of cellDataList must be of type CellData.
    NSMutableArray *cellDataList;
    
    // The TableData instance is assumed to be a subview of a navigation
    // controller, and must be given a reference to it.
    UINavigationController *controller;
    
    UITableView *currentTableView;
}

@property (retain) NSString *tableName;
@property (retain) NSMutableArray *cellDataList;

-(TableData *) initWithNavigationController:(UINavigationController *) aController;

-(UITableView *) synthesizeUITableView;

@end
