//
//  CustomViewCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"

@implementation CustomViewCell

- (id)init
{
    
    self = [super initWithStyle:[[self class] cellStyle] reuseIdentifier:[[self class] cellIdentifier]];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
        UIFont *descFont = [UIFont fontWithName:@"HelveticaNeue" size:13];
        
        [[self textLabel] setFont:titleFont];
        [[self detailTextLabel] setFont:descFont];
        
        [[self textLabel] setAdjustsFontSizeToFitWidth:YES];
        [[self detailTextLabel] setAdjustsFontSizeToFitWidth:YES];
        
    }
    return self;
}

+(NSString*)cellIdentifier{
    return @"CustomCell";
}

+(UITableViewCellStyle)cellStyle
{
    return UITableViewCellStyleValue1;
}

@end
