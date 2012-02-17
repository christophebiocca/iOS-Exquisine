//
//  MenuCompositeCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuCompositeCell.h"
#import "MenuComponent.h"

@implementation MenuCompositeCell

+(NSString*)cellIdentifier{
    return @"MenuCompositeCell";
}

-(void)setMenuComponent:(MenuComponent *)aMenuComponent
{
    componentInfo = aMenuComponent;
    [[self detailTextLabel] setText:[componentInfo desc]];
    [[self textLabel] setText:[componentInfo name]];
    
}

@end
