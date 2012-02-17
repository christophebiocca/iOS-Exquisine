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

-(void)setMenuComponent:(Combo*)theCombo{
    
    combo = theCombo;
    
    [self setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    
    [super setMenuComponent:theCombo];
    
    UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
    UIFont *descFont = [UIFont fontWithName:@"HelveticaNeue" size:17];
    [[self textLabel] setFont:titleFont];
    [[self detailTextLabel] setFont:descFont];
    
}

-(void)updateCell
{
    [super updateCell];
    [[self detailTextLabel] setText:@""];
    [self setNeedsDisplay];
}

@end
