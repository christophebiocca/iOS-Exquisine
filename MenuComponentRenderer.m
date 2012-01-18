//
//  MenuComponentRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponentRenderer.h"
#import "MenuComponent.h"

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

@end
