//
//  ItemGroupCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-31.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemGroupCell.h"

@implementation ItemGroupCell


@synthesize itemGroup;

+(NSString *)cellIdentifier{
    return @"ItemGroupCell";
}

- (id)init
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[ItemGroupCell cellIdentifier]];
    if (self) {
        
    }
    return self;
}

-(void)setItemGroup:(ItemGroup *)theItemGroup
{   
    itemGroup = theItemGroup;
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
    UIFont *descFont = [UIFont fontWithName:@"HelveticaNeue" size:13];
    
    [[self textLabel] setFont:titleFont];
    [[self detailTextLabel] setFont:descFont];
    
    [[self textLabel] setText:[itemGroup name]];
    [[self textLabel] setAdjustsFontSizeToFitWidth:YES];
    [[self detailTextLabel] setText:@""];
    
    if([itemGroup satisfied])
    {
        [self setAccessoryType:UITableViewCellAccessoryCheckmark];
        [self setBackgroundColor:[UIColor colorWithRed:0.83f green:1.0f blue:0.83f alpha:1.0f]];
    }
    else
    {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [self setBackgroundColor:[UIColor colorWithRed:1.0f green:0.83f blue:0.83f alpha:1.0f]];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

@end
