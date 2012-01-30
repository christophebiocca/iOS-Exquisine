//
//  MenuCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Menu;


@interface MenuCell : UITableViewCell{
    Menu *menu;
}

@property (nonatomic, retain) Menu *menu;

+ (NSString*)cellIdentifier;
    
- (id)init;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

@end
