//
//  ComboMenuCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComboMenuCell.h"
#import "Combo.h"

@implementation ComboMenuCell

+(NSString *)cellIdentifier{
    return @"ComboMenuCell";
}

-(void)setData:(id)theCombo{
    
    combo = theCombo;
    
    [self setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    
    [super setData:theCombo];
    
}

-(void)updateCell
{
    [super updateCell];
    [[self detailTextLabel] setText:@""];
    [self setNeedsDisplay];
}

@end
