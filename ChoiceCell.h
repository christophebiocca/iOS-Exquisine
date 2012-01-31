//
//  ChoiceCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Choice;

@interface ChoiceCell : UITableViewCell
{
    Choice *choice;
}

@property (nonatomic,retain) Choice *choice;

+(NSString*)cellIdentifier;

- (id)init;

@end
