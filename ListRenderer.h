//
//  Renderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//This superclass really doesn't do anything. It might some day though.

#import <Foundation/Foundation.h>
#import "CustomViewCell.h"

@interface ListRenderer : NSObject <UITableViewDataSource>
{
    NSMutableArray *listData;
    NSMutableArray *sectionNames;
}

@property (retain) NSMutableArray *listData;
@property (retain) NSMutableArray *sectionNames;

-(id)objectForCellAtIndex:(NSIndexPath *)index;

@end
