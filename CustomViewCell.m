//
//  CustomViewCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"
#import "Utilities.h"

@implementation CustomViewCell

+(CustomViewCell *)customViewCellFromData:(id)data
{
    for (Class eachSubclass in [CustomViewCell subclasses]) {
        if ([eachSubclass canDisplayData:data]) {
            CustomViewCell *returnCell = [[eachSubclass alloc] init];
            [returnCell setData:data];
            return returnCell;
        }
    }
    
    CLLog(LOG_LEVEL_WARNING, @"An unknown data type was passed to customViewCellFromData.");
    return nil;
}

+(NSString *)cellIdentifierForData:(id)data
{
    for (Class eachSubclass in [CustomViewCell subclasses]) {
        if ([eachSubclass canDisplayData:data]) {
            return [eachSubclass cellIdentifier];
        }
    }
    
    CLLog(LOG_LEVEL_WARNING, @"An unknown data type was passed to cellIdentifierForData.");
    return nil;
}

+(CGFloat)cellHeightForData:(id)data
{
    for (Class eachSubclass in [CustomViewCell subclasses]) {
        if ([eachSubclass canDisplayData:data]) {
            return [eachSubclass cellHeightForData:data];
        }
    }
    CLLog(LOG_LEVEL_WARNING, @"An unknown data type was passed to cellHeightForData.");
    return 0;
}

+(BOOL)canDisplayData:(id)data
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

+(NSString*)cellIdentifier{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (id)init
{
    
    self = [super initWithStyle:[[self class] cellStyle] reuseIdentifier:[[self class] cellIdentifier]];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
        UIFont *descFont = [UIFont fontWithName:@"HelveticaNeue" size:17];
        
        [[self textLabel] setFont:titleFont];
        [[self detailTextLabel] setFont:descFont];
        
        [[self textLabel] setAdjustsFontSizeToFitWidth:YES];
        [[self detailTextLabel] setAdjustsFontSizeToFitWidth:YES];
        
    }
    return self;
}

-(void) setData:(id) data
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

+(UITableViewCellStyle)cellStyle
{
    return UITableViewCellStyleValue1;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
