//
//  Menu.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Submenu;

@interface Menu : NSObject{
    
    NSString *restarauntName;
    NSMutableArray *submenuList;
    
}

@property (retain) NSString *resterauntName;
@property (retain) NSMutableArray *submenuList;

-(void) addSubmenu:(Submenu *) aSubmenu;

@end
