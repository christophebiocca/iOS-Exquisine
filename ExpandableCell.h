//
//  ExpandableCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"
@class ExpandableCellData;

@interface ExpandableCell : CustomViewCell
{
    ExpandableCellData *expandableData;
    UIImageView *colapsedImage;
    UIImageView *expandedImage;
    UILabel *nameLabel;
    UILabel *numberOfItemsLabel;
}

-(void) toggleOpen:(NSIndexPath *) selfLocation : (UITableView *) table;

-(void) initializeOpen;

-(void) initializeClosed;

-(void) transitionToOpen:(NSIndexPath *) selfLocation:(UITableView *)table;

-(void) transitionToClosed:(NSIndexPath *) selfLocation:(UITableView *)table;

@end