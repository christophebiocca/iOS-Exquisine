//
//  Submenu.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Item;

//Submenus simply have all of the possible items
//that someone could select from a section.
@interface Submenu : NSObject{
    
    NSString *name;
    NSMutableArray *itemList;
    
}

@property (retain) NSString *name;
@property (retain) NSMutableArray *itemList;

-(void) addItem:(Item *) anItem;

@end
