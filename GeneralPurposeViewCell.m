//
//  GeneralPurposeViewCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeneralPurposeViewCell.h"

@implementation GeneralPurposeViewCell

+(CustomViewCell *)customViewCellWithTitle:(NSString *) aTitle AndDescription:(NSString *)aDescription
{
    CustomViewCell *returnCell = [[CustomViewCell alloc] init];
    
    [[returnCell textLabel] setText:aTitle];
    [[returnCell detailTextLabel] setText:aDescription];
    
    return returnCell;
    
}

@end
