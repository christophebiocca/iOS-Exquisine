//
//  MenuCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuCell.h"
#import "Menu.h"
#import "Utilities.h"

@implementation MenuCell

@synthesize menu;

+(NSString*)cellIdentifier{
    return @"MenuCell";
}

- (id)init
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[MenuCell cellIdentifier]];
    if (self) {
        
    }
    return self;
}

-(void)setMenu:(Menu *)theMenu
{
    menu = theMenu;

    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
    UIFont *descFont = [UIFont fontWithName:@"HelveticaNeue" size:17];
    
    [[self textLabel] setFont:titleFont];
    [[self detailTextLabel] setFont:descFont];
    
    [[self textLabel] setText:[menu name]];
    [[self textLabel] setAdjustsFontSizeToFitWidth:YES];
    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
