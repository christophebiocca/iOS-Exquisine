//
//  MenuComponent.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//Menu Components are meant to be strictly model classes. They should contain no information
//about how to display themselves, or how to load themselves.

//They will, however, check to make sure that their state is sane. It is up to the 
//owner to be looking for failing setters, but it is up to the model to regulate its state.

#import <Foundation/Foundation.h>
#import "AutomagicalCoder.h"

extern NSString* MENU_COMPONENT_NAME_CHANGED;
extern NSString* MENU_COMPONENT_DESC_CHANGED;
extern NSString* MENU_COMPONENT_PK_CHANGED;

@interface MenuComponent :AutomagicalCoder {
    NSString *name;
    NSString *desc;
    NSUInteger primaryKey;
}

@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) NSString *desc;
@property (readonly) NSUInteger primaryKey;

-(MenuComponent *) initFromData:(NSDictionary *) inputData;

-(MenuComponent *) copy;

-(NSString *) descriptionWithIndent:(NSInteger) indent;

-(NSString *) description;

@end
