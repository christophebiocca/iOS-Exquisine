//
//  ChoiceRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChoiceRenderer.h"
#import "Utilities.h"
#import "Choice.h"
#import "CellData.h"

@implementation ChoiceRenderer

-(ChoiceRenderer *)initWithChoice:(Choice *)aChoice
{
    choiceInfo = aChoice;
    return self;
}

-(UITableViewCell *)configureCell:(UITableViewCell *)aCell
{
    
    aCell.textLabel.text = [choiceInfo name];
    if([choiceInfo isFree]){
        aCell.detailTextLabel.text = @"Free";
    } else {
        aCell.detailTextLabel.text = [Utilities FormatToPrice:[choiceInfo price]];
    }
    
    if (choiceInfo.selected){
        [aCell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else
    {
        [aCell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    return aCell;
}

-(NSArray *)detailedStaticRenderList
{
    NSMutableArray *returnList = [[NSMutableArray alloc] initWithCapacity:0];
    
    CellData *newCell = [super detailedStaticRenderDefaultCell];
    [newCell setCellDesc:[Utilities FormatToPrice:[choiceInfo price]]];
    [newCell setCellTitle:[choiceInfo name]];
    [newCell setCellSwitchState:[choiceInfo selected]];
    
    [returnList addObject:newCell];
    
    return returnList;
}

@end
