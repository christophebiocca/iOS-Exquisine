//
//  Choice.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuComponent.h"

@interface Choice : MenuComponent{
    //This price is the price of the choice assuming no special rules apply
    //(i.e. if this is one of the choices that you get free of charge)
    NSInteger normalPriceCents;
    
    //This price is the price of the choice with special rules applied.
    //The user is expected to manage this value, as it will relate to
    //Circumstances that only the user will know.
    NSInteger effectivePriceCents;
    
    BOOL selected;
}

@property NSInteger normalPriceCents;
@property NSInteger effectivePriceCents;
@property BOOL selected;

-(Choice *)initFromChoice:(Choice *) aChoice;

-(Choice *)initFromData:(NSData *) inputData;

-(NSString *)description;

-(void)toggleSelected;

@end
