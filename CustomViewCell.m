//
//  CustomViewCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"
#import "MenuCompositeCell.h"
#import "GeneralPurposeViewCell.h"
#import "GeneralPurposeViewCellData.h"
#import "MenuComponent.h"

@implementation CustomViewCell

+(CustomViewCell *)customViewCellFromData:(id)data AndContext:(CellContext)context
{
    
    if ([data isKindOfClass:[MenuComponent class]]) {
        return [MenuCompositeCell customViewCellWithMenuComponent:data AndContext:context];
    }
    if ([data isKindOfClass:[NSDictionary class]]) {
        return [MenuCompositeCell customViewCellWithMenuComponent:[data objectForKey:@"data"]AndContext:[[data objectForKey:@"context"] intValue]];
    }
    if ([data isKindOfClass:[GeneralPurposeViewCellData class]]) {
        return [GeneralPurposeViewCell customViewCellWithGeneralData:data];
    }
    
    CLLog(LOG_LEVEL_WARNING, @"An unknown data type was passed to customViewCellFromData.");
    return nil;
}

+(NSString *)cellIdentifierForData:(id)data AndContext:(CellContext)context
{
    
    if ([data isKindOfClass:[MenuComponent class]]) {
        return [MenuCompositeCell cellIdentifierWithMenuComponent:data AndContext:context];
    }
    if ([data isKindOfClass:[GeneralPurposeViewCellData class]]) {
        return [GeneralPurposeViewCell cellIdentifier];
    }
    if ([data isKindOfClass:[NSDictionary class]]) {
        return [GeneralPurposeViewCell cellIdentifier];
    }
    
    CLLog(LOG_LEVEL_WARNING, @"An unknown data type was passed to cellIdentifierForData.");
    return nil;
}

-(void) setData:(id) data
{
  
}

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

-(void)setStyle:(CellStyle)style
{
    
}

+(NSString*)cellIdentifier{
    return @"CustomCell";
}

+(UITableViewCellStyle)cellStyle
{
    return UITableViewCellStyleValue1;
}

@end
