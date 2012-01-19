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
    UIColor *cellColour; //<-- canadian spelling =b
}

@property (retain) NSString *cellTitle;
@property (retain) NSString *cellDesc;
@property (retain) UIColor *cellColour;
@property BOOL cellSwitchState;

//Configures a table view cell to be representative
//of the data that is populated in the CellData object
-(UITableViewCell *)configureCell: (UITableViewCell *) newCell;

@end
