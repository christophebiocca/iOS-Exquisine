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

@interface MenuComponent : NSObject {
    NSString *name;
    NSString *desc;
    NSInteger primaryKey;
}

@property (retain) NSString *name;
@property (retain) NSString *desc;
@property NSInteger primaryKey;

-(MenuComponent *) initFromData:(NSData *) inputData;

@end
