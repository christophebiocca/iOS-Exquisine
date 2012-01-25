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

@end
