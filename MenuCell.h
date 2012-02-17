//
//  MenuCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuCompositeCell.h"

@class Menu;


@interface MenuCell : MenuCompositeCell{
    Menu *menu;
}

@property (nonatomic, retain) Menu *menu;

+ (NSString*)cellIdentifier;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

@end
