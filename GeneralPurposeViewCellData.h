//
//  GeneralPurposeViewCellData.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"

@interface GeneralPurposeViewCellData : CustomViewCell
{
    NSString *title;
    NSString *description;
    UIFont *titleFont;
    UIFont *descriptionFont;
}


@property (retain) NSString *title;
@property (retain) NSString *description;
@property (retain) UIFont *titleFont;
@property (retain) UIFont *descriptionFont;

@end
