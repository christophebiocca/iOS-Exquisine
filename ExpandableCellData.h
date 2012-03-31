//
//  ExpandableCellData.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ListRenderer;

@interface ExpandableCellData : NSObject
{
    BOOL isOpen;
    id primaryItem;
    NSMutableArray *expansionContents;
    ListRenderer *renderer;
}

-(id) initWithPrimaryItem:(id)aThing AndRenderer:(ListRenderer *)aRenderer;

@property BOOL isOpen;
@property (retain) id primaryItem;
@property (retain) NSMutableArray *expansionContents;
@property (retain) ListRenderer *renderer;

@end
