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
#import <QuartzCore/QuartzCore.h>

@implementation ComboCell

@synthesize combo;
@synthesize style;

+(NSString *)cellIdentifier{
    return @"ComboCell";
}

static UIImage* deleteImage = nil;

+(void)initialize{
    if(!deleteImage){
        deleteImage = [UIImage imageNamed:@"Delete"];
    }
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
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
    UIFont *descFont = [UIFont fontWithName:@"HelveticaNeue" size:13];
    
    [[self textLabel] setFont:titleFont];
    [[self detailTextLabel] setFont:descFont];
    
    [[self textLabel] setText:[combo name]];
    [[self textLabel] setAdjustsFontSizeToFitWidth:YES];
    [[self detailTextLabel] setText:@""];
    [[self detailTextLabel] setAdjustsFontSizeToFitWidth:YES];
    
    if( [style isEqualToString:@"plain"])
    {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
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
            [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
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
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
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
            [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [self setBackgroundColor:[UIColor whiteColor]];
        }
    }
}

-(void)willTransitionToState:(UITableViewCellStateMask)state{
    [super willTransitionToState:state];
    if(state & UITableViewCellStateShowingDeleteConfirmationMask){
        for(UIView* subview in [self subviews]){
            if([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationControl"]){
                UIView* buttonThingy = [[subview subviews] objectAtIndex:0];
                [[buttonThingy layer] setContents:(id)[deleteImage CGImage]];
            }
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

@end
