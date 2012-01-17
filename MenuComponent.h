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
}

@property(readonly)TableData* tableData;
@property(readonly)CellData* cellData;

@end
