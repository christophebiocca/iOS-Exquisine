//
//  Menu.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuComponent.h"

@interface Menu : MenuComponent{
    
    NSMutableArray *submenuList;
    
}

@property (retain,readonly) NSMutableArray *submenuList;

-(Menu *) init;

-(void) addSubmenu:(Menu *) aSubmenu;

-(Menu *) initFromData:(NSDictionary *)inputData;

@end
