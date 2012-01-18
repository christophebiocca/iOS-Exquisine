//
//  CellData.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VisualizableData.h"

@interface CellData : VisualizableData{
    
    NSString *cellTitle;
    NSString *cellDesc;
    BOOL cellSwitchState;
}

@property (retain) NSString *cellTitle;
@property (retain) NSString *cellDesc;
@property BOOL cellSwitchState;

//Configures a table view cell to be representative
//of the data that is populated in the CellData object
-(UITableViewCell *)configureCell: (UITableViewCell *) newCell;

@end
