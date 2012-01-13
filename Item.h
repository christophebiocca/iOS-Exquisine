//
//  Item.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Option.h"

@interface Item : NSObject{
    NSString *name;
    NSInteger basePriceCents;
    NSMutableArray *options;
    NSString *desc;
}

@property (retain) NSString *name;
@property NSInteger basePriceCents;
@property (retain, readonly) NSMutableArray *options; 
@property (retain) NSString *desc;

-(NSString *)description;

-(NSInteger)totalPrice;

-(id)init;

-(void) addOption:(Option *) anOption;

@end

