//
//  MenuComponentRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponentRenderer.h"
#import "MenuComponent.h"
#import "CellData.h"

@implementation MenuComponentRenderer

-(MenuComponentRenderer *)initWithMenuComponent:(MenuComponent *)aMenuComponent
{
    menuComponent = aMenuComponent;
    return self;
}

-(UITableViewCell *) configureCell:(UITableViewCell *) aCell
{
    [[aCell detailTextLabel] setText:menuComponent.desc];
    [[aCell textLabel] setText:menuComponent.name];
    return aCell;
}

-(CellData *) detailedStaticRenderDefaultCell
{
    CellData *newCell = [[CellData alloc] init];
    [newCell setCellTitleFontSize: 13];
    [newCell setCellTitleFontType: @"Noteworthy-Bold"];
    [newCell setCellDescFontSize: 13];
    [newCell setCellDescFontType: @"Noteworthy-Light"];
    return newCell;
}

@end
