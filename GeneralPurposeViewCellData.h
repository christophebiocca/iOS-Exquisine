//
//  GeneralPurposeViewCellData.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"

extern NSString* VIEW_CELL_NEEDS_REDRAW;

@interface GeneralPurposeViewCellData : NSObject
{
    NSString *title;
    UIFont *titleFont;
    NSString *description;
    UIFont *descriptionFont;
    NSInteger indent;
    UIColor *cellColour;
    BOOL disclosureArrow;
    CGFloat height;
}

@property (nonatomic) BOOL disclosureArrow;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) UIFont *titleFont;
@property (nonatomic, retain) UIFont *descriptionFont;
@property (nonatomic) NSInteger indent;
@property (nonatomic, retain) UIColor *cellColour;
@property (nonatomic) CGFloat height;

@end
