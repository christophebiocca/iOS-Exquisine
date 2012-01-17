//
//  MenuComponent.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TableData;
@class CellData;

@interface MenuComponent : NSObject {
    TableData* tableData;
    CellData* cellData;
    UINavigationController *controller;
}

@property(readonly)TableData* tableData;
@property(readonly)CellData* cellData;

- (MenuComponent *) initWithNavigationController: (UINavigationController *) aController;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)initializeTableData;

- (void)initializeCellData;



@end
