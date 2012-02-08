//
//  ComboCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComboCell.h"
#import "Combo.h"
#import "Utilities.h"

@implementation ComboCell

@synthesize combo;
@synthesize style;

+(NSString *)cellIdentifier{
    return @"ComboCell";
}

- (id)init
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[ComboCell cellIdentifier]];
    if (self) {
        
    }
    return self;
    style = @"plain";
    combo = [[Combo alloc] init];
}

-(void)setCombo:(Combo*)theCombo{
    
    combo = theCombo;
    
    UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
    UIFont *descFont = [UIFont fontWithName:@"HelveticaNeue" size:13];
    
    [[self textLabel] setFont:titleFont];
    [[self detailTextLabel] setFont:descFont];
    
    [[self textLabel] setText:[combo name]];
    [[self detailTextLabel] setText:@""];
    
    if( [style isEqualToString:@"plain"])
    {
        [self setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    else if ( [style isEqualToString:@"fancy"])
    {
        if([combo satisfied])
        {
            [self setAccessoryType:UITableViewCellAccessoryCheckmark];
            [self setBackgroundColor:[UIColor colorWithRed:0.6f green:0.9f blue:0.6f alpha:1.0f]];
        }
        else
        {
            [self setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
            [self setBackgroundColor:[UIColor whiteColor]];
        }
    }
    else if ( [style isEqualToString:@"with_price"])
    {
        [[self detailTextLabel] setText:[Utilities FormatToPrice:[combo price]]];
    }
    
}

-(void)setStyle:(NSString *)aStyle
{
    style = aStyle;
    if( [style isEqualToString:@"plain"])
    {
        [self setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    else if ( [style isEqualToString:@"fancy"])
    {
        if([combo satisfied])
        {
            [self setAccessoryType:UITableViewCellAccessoryCheckmark];
            [self setBackgroundColor:[UIColor colorWithRed:0.6f green:0.9f blue:0.6f alpha:1.0f]];
        }
        else
        {
            [self setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
            [self setBackgroundColor:[UIColor whiteColor]];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

@end
