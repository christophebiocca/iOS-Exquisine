//
//  Item.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Option.h"
#import "MenuComponent.h"

@interface Item : MenuComponent{
    NSString *name;
    NSInteger basePriceCents;
    NSMutableArray *options;
    NSString *desc;
}

@property (retain, readonly) NSMutableArray *options; 

-(NSString *)description;


-(id)initWithNavigationController:(UINavigationController *) aController;

-(void) setBasePrice:(NSInteger) anInt;

-(void) addOption:(Option *) anOption;

-(void) setName:(NSString *)aName;

-(void) setDesc:(NSString *)aDesc;

-(NSInteger)totalPrice;

@end

