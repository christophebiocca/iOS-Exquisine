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
    NSString *cellAccessory;
    UITableViewCellStyle cellStyle;
    NSInteger cellTabbing;
    NSInteger cellTitleFontSize;
    NSString *cellTitleFontType;
    NSInteger cellDescFontSize;
    NSString *cellDescFontType;
}

@property (retain) NSString *cellTitle;
@property (retain) NSString *cellDesc;
@property (retain) UIColor *cellColour;
@property BOOL cellSwitchState;
@property (retain) NSString *cellAccessory;
@property UITableViewCellStyle cellStyle;
@property NSInteger cellTitleFontSize;
@property NSInteger cellDescFontSize;
@property (retain) NSString *cellTitleFontType;
@property (retain) NSString *cellDescFontType;

//Configures a table view cell to be representative
//of the data that is populated in the CellData object
-(UITableViewCell *)configureCell: (UITableViewCell *) newCell;

-(void) tab;

@end
