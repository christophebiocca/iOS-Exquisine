//
//  ChoiceCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuCompositeCell.h"

@class Choice;

@interface ChoiceCell : MenuCompositeCell
{
    Choice *choice;
}

-(void)setMenuComponent:(Choice*)theChoice;

+(NSString*)cellIdentifier;

@end
