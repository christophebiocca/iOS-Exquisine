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

+(NSString *)cellIdentifier{
    return @"ComboCell";
}

- (id)init
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[ComboCell cellIdentifier]];
    if (self) {
        
    }
    return self;
}

-(void)setCombo:(Combo*)theCombo{
    
    combo = theCombo;
    
    UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
    UIFont *descFont = [UIFont fontWithName:@"HelveticaNeue" size:13];
    
    [[self textLabel] setFont:titleFont];
    [[self detailTextLabel] setFont:descFont];
    
    [[self textLabel] setText:[combo name]];
    [[self detailTextLabel] setText:[Utilities FormatToPrice:[combo price]]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

@end
