//
//  GeneralPurposeViewCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeneralPurposeViewCell.h"
#import "GeneralPurposeViewCellData.h"

@implementation GeneralPurposeViewCell

+(CustomViewCell *)customViewCellWithGeneralData:(GeneralPurposeViewCellData *) theCellData
{
    CustomViewCell *returnCell = [[GeneralPurposeViewCell alloc] initWithCellData:theCellData];
    
    return returnCell;
}

-(id)initWithCellData:(GeneralPurposeViewCellData *)theData
{
    self = [super init];
    if (self) {
        [self setData:theData];
    }
    
    return self;
}

+(BOOL)canDisplayData:(id)data
{
    return [data isKindOfClass:[GeneralPurposeViewCellData class]];
}

-(void)setData:(GeneralPurposeViewCellData *) theCellData
{
    
    if ([theCellData isKindOfClass:[GeneralPurposeViewCellData class]]) 
    {
        cellData = theCellData;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCell) name:VIEW_CELL_NEEDS_REDRAW object:theCellData];
        [self updateCell];
    }
    else
    {
        CLLog(LOG_LEVEL_ERROR, @"An incorrect data type was sent to GeneralPurposeViewCell's setData:");
    }
}

-(void)updateCell
{
    [[self textLabel] setText:[cellData title]];
    [self setIndentationLevel:([cellData indent] * 3)];
    [self setBackgroundColor:[cellData cellColour]];
    
    if ([cellData titleFont]) {
        [[self textLabel] setFont:[cellData titleFont]];
    }
    
    [[self detailTextLabel] setText:[cellData description]];
    
    if ([cellData descriptionFont]) {
        [[self detailTextLabel] setFont:[cellData descriptionFont]];
    }
    if ([cellData disclosureArrow])
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    else
        [self setAccessoryType:UITableViewCellAccessoryNone];
    
}

+(NSString *)cellIdentifier
{
    return @"GeneralPurposeCell";
}

+(CGFloat)cellHeightForData:(id)data
{
    return 44.0f;
}

@end
