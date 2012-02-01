//
//  ComboCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Combo;

@interface ComboCell : UITableViewCell
{
    Combo *combo;
    NSString *style;
}

@property (nonatomic,retain) Combo *combo;
@property (nonatomic,retain) NSString *style;

-(id)init;

+(NSString *) cellIdentifier;

@end
