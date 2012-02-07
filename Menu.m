//
//  Menu.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Menu.h"
#import "Item.h"
#import "Combo.h"

@implementation Menu

@synthesize submenuList, comboList;

-(Menu *)init
{
    self = [super init];
    
    submenuList = [[NSMutableArray alloc] initWithCapacity:0];
    comboList = [[NSMutableArray alloc] initWithCapacity:0];    
    
    return self;
}

-(Menu *) initFromData:(NSDictionary *)inputData
{
    self = [super initFromData:inputData];
    
    submenuList = [[NSMutableArray alloc] initWithCapacity:0];
    comboList = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSDictionary *submenu in [inputData objectForKey:@"submenus"]) 
    {
        Menu *newSubmenu = [[Menu alloc] initFromDataAndRootMenu:submenu:self];
        [submenuList addObject:newSubmenu];
    }
    
    for (NSDictionary *item in [inputData objectForKey:@"items"]) 
    {
        Item *newItem = [[Item alloc] initFromData:item];
        [submenuList addObject:newItem];
    }
    
    for (NSDictionary *combo in [inputData objectForKey:@"combos"]) 
    {
        Combo *newCombo = [[Combo alloc] initFromDataAndMenu:combo :self];
        [comboList addObject:newCombo];
    }
    
    return self;
}

-(Menu *) initFromDataAndRootMenu:(NSDictionary *)inputData :(Menu *)theRootMenu
{
    self = [super initFromData:inputData];
    
    submenuList = [[NSMutableArray alloc] initWithCapacity:0];
    comboList = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSDictionary *submenu in [inputData objectForKey:@"submenus"]) 
    {
        Menu *newSubmenu = [[Menu alloc] initFromDataAndRootMenu:submenu:theRootMenu];
        [submenuList addObject:newSubmenu];
    }
    
    for (NSDictionary *item in [inputData objectForKey:@"items"]) 
    {
        Item *newItem = [[Item alloc] initFromData:item];
        [submenuList addObject:newItem];
    }
    
    for (NSDictionary *combo in [inputData objectForKey:@"combos"]) 
    {
        Combo *newCombo = [Combo comboWithDataAndMenu:combo:theRootMenu];
        [comboList addObject:newCombo];
    }
    
    return self;
}

- (MenuComponent *)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        submenuList = [decoder decodeObjectForKey:@"submenu_list"];
        comboList = [decoder decodeObjectForKey:@"combo_list"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Rinse and repeat this:
    [super encodeWithCoder:encoder];
    [encoder encodeObject:submenuList forKey:@"submenu_list"];
    [encoder encodeObject:comboList forKey:@"combo_list"];
}

-(Menu *)copy
{
    Menu *newMenu = [[Menu alloc] init];
    
    for (id aMenu in submenuList) {
        [newMenu addSubmenu:[aMenu copy]];
    }
    
    for (Combo * aCombo in comboList) {
        [newMenu addCombo:[aCombo copy]];
    }
    
    return newMenu;
}

-(Item *)dereferenceItemPK:(NSInteger)itemPK
{
    for (id possibleContainers in submenuList) {
        if([possibleContainers isKindOfClass:[Item class]])
        {
            if([possibleContainers primaryKey] == itemPK)
                return possibleContainers;
        }
        if([possibleContainers isKindOfClass:[Menu class]])
        {
            Item *maybeTheItem = [possibleContainers dereferenceItemPK:itemPK];
            if (maybeTheItem != nil)
                return maybeTheItem;
        }
    }
    return nil;
}

-(Menu *)dereferenceMenuPK:(NSInteger)menuPK
{
    if (primaryKey == menuPK)
        return self;
    
    for (id possibleMenus in submenuList) {
        if([possibleMenus isKindOfClass:[Menu class]])
        {
            id maybeMenu = [possibleMenus dereferenceMenuPK:menuPK];
            if (maybeMenu != nil)
            {
                return maybeMenu;
            }
        }
    }
    
    return nil;
}

-(NSArray *)flatItemList
{
    NSMutableArray *returnList = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (id possibleContainers in submenuList) {
        if([possibleContainers isKindOfClass:[Item class]])
        {
            [returnList addObject:possibleContainers];
        }
        if([possibleContainers isKindOfClass:[Menu class]])
        {
            [returnList addObjectsFromArray:[possibleContainers flatItemList]];
        }
    }
    
    return returnList;
}

-(NSArray *)recursiveComboList
{
    NSMutableArray *outputList = [[NSMutableArray alloc] initWithArray:comboList];
    
    for (id aMenu in submenuList) {
        if ([aMenu isKindOfClass:[Menu class]])
            [outputList addObjectsFromArray:[(Menu *)aMenu recursiveComboList]];
    }
    
    return outputList;
}

-(void)addSubmenu:(Menu *)aSubmenu
{
    [submenuList addObject:aSubmenu];
}

-(void)addCombo:(Combo *)aCombo
{
    [comboList addObject:aCombo];
}

-(BOOL)isEffectivelyEqual:(id)aMenu
{
    if(![aMenu isKindOfClass:[Menu class]])
        return NO;
    
    if([[aMenu submenuList] count] != [[self submenuList] count])
        return NO;
    
    for (int i = 0; i < [[aMenu submenuList] count]; i++) {
        if (![[[aMenu submenuList] objectAtIndex:i] isEffectivelyEqual:[submenuList objectAtIndex:i]]) {
            return NO;
        }
    }
    
    if([[aMenu comboList] count] != [[self comboList] count])
        return NO;
    
    for (int i = 0; i < [[aMenu comboList] count]; i++) {
        if (![[[aMenu comboList] objectAtIndex:i] isEffectivelyEqual:[comboList objectAtIndex:i]]) {
            return NO;
        }
    }
    
    return YES;
}

- (NSString *) descriptionWithIndent:(NSInteger) indentLevel
{    
    NSString *padString = [@"" stringByPaddingToLength:(indentLevel*4) withString:@" " startingAtIndex:0];
    
    NSMutableString *output = [[NSMutableString alloc] initWithCapacity:0];
    
    [output appendFormat:@"%@Menu:%\n",padString];
    [output appendString:[super descriptionWithIndent:indentLevel]];
    [output appendFormat:@"%@Combos:\n",padString];
    
    for (Combo *aCombo in comboList) {
        [output appendFormat:@"%@\n",[aCombo descriptionWithIndent:(indentLevel + 1)]];
    }
    
    [output appendFormat:@"%@Submenus:\n",padString];
    
    for (id aMenu in submenuList) {
        if ([aMenu isKindOfClass:[Menu class]]) {
            [output appendFormat:@"%@\n",[aMenu descriptionWithIndent:(indentLevel + 1)]];
        }
    }
    
    [output appendFormat:@"%@Items:\n",padString];
    
    for (id anItem in submenuList) {
        if ([anItem isKindOfClass:[Item class]]) {
            [output appendFormat:@"%@\n",[anItem descriptionWithIndent:(indentLevel + 1)]];
        }
    }
    
    return output;
}

@end
