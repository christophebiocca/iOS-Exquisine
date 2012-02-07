//
//  ItemMenuCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemMenuCell.h"
#import "Item.h"
#import "Utilities.h"

@implementation ItemMenuCell

@synthesize item;

+(NSString*)cellIdentifier{
    return @"ItemMenuCell";
}

- (id)init
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[ItemMenuCell cellIdentifier]];
    if (self) {
        
    }
    return self;
}

-(void)setItem:(Item*)theItem
{
    
    item = theItem;
    
    UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
    UIFont *descFont = [UIFont fontWithName:@"HelveticaNeue" size:17];
    
    [[self textLabel] setFont:titleFont];
    [[self detailTextLabel] setFont:descFont];
    
    [self calcFontSizeToFitRect:CGRectMake(0, 0, 240, 40)];
    
    [[self textLabel] setText:[item name]];
    [[self detailTextLabel] setText:[Utilities FormatToPrice:[item price]]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)calcFontSizeToFitRect:(CGRect)r {
    float targetWidth = r.size.width - 10;
    float targetHeight = r.size.height - 5;
    
    // the strategy is to start with a small font size and go larger until I'm larger than one of the target sizes
    int i;
    for (i=9; i<18; i++) {
        UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:i];
        CGSize strSize = [[item name] sizeWithFont :titleFont];
        if (strSize.width > targetWidth || strSize.height > targetHeight) break;
    }
    UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:i-1];
    [[self textLabel] setFont:titleFont];
}

@end
