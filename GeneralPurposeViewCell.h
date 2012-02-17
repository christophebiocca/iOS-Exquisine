//
//  GeneralPurposeViewCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"
@class GeneralPurposeViewCellData;

@interface GeneralPurposeViewCell : CustomViewCell
{
    GeneralPurposeViewCellData *cellData;
}

-(id)initWithCellData:(GeneralPurposeViewCellData *) theData;

+(CustomViewCell *)customViewCellWithGeneralData:(GeneralPurposeViewCellData *) theCellData;

-(void)updateCell;

-(void)setData:(GeneralPurposeViewCellData *) theCellData;

@end
