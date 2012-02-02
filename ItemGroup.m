//
//  ItemGroup.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-31.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemGroup.h"
#import "Menu.h"
#import "Item.h"
#import "Order.h"
#import "Combo.h"

@implementation ItemGroup

@synthesize listOfItems;

-(ItemGroup *)initWithDataAndParentMenuAndParentCombo:(NSDictionary *)inputData :(Menu *)inputMenu :(Combo *)aCombo
{
    //self = [super initFromData:inputData];
    
    parentCombo = aCombo;
    
    name = @"Placeholder";
    
    parentMenu = inputMenu;
    
    listOfItems = [[NSMutableArray alloc] initWithCapacity:0];
        
    NSMutableArray *itemPKs = [inputData objectForKey:@"items"];
    NSMutableArray *menuPKs = [inputData objectForKey:@"menus"] ;
    
    for (NSString *itemPK in itemPKs) 
    {
        NSInteger intItemPK = [itemPK intValue];
        Item *itemToAdd = [parentMenu dereferenceItemPK:intItemPK];
        [listOfItems addObject:itemToAdd];
    }
    
    for (NSString *menuPK in menuPKs)
    {
        Menu *menuForPK = [parentMenu dereferenceMenuPK:[menuPK intValue]];
        [listOfItems addObjectsFromArray:[menuForPK flatItemList]];
    }
    
    return self;
    
}

-(BOOL)containsItem:(Item *)anItem
{
    for (Item *item in listOfItems) {
        if ([anItem.name isEqualToString:item.name]) {
            return YES;
        }
    }
    return NO;
}

-(void)addItem:(Item *)anItem
{
    [listOfItems addObject:anItem];
}

-(void) addListOfItems:(NSArray *)items
{
    [listOfItems addObjectsFromArray:items];
}

-(void)addMenu:(Menu *)aMenu
{
    [listOfItems addObjectsFromArray:[aMenu flatItemList]];
}

- (MenuComponent *)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        parentCombo = [decoder decodeObjectForKey:@"parent_combo"];
        parentMenu = [decoder decodeObjectForKey:@"parent_menu"];
        listOfItems = [decoder decodeObjectForKey:@"list_of_items"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Rinse and repeat this:
    [super encodeWithCoder:encoder];    
    [encoder encodeObject:parentCombo forKey:@"parent_combo"];
    [encoder encodeObject:parentMenu forKey:@"parent_menu"];
    [encoder encodeObject:listOfItems forKey:@"list_of_items"];
}

- (NSString *) descriptionWithIndent:(NSInteger) indentLevel
{    
    NSMutableString *output = [NSMutableString stringWithString:[@"" stringByPaddingToLength:(indentLevel*4) withString:@" " startingAtIndex:0]];
    
    [output appendFormat:@"ItemGroup: %@:\n",name];
    
    for (Item *anItem in listOfItems) {
        [output appendFormat:@"%@\n",[anItem descriptionWithIndent:(indentLevel + 1)]];
    }
    
    return output;
}

-(NSString *)description{
    
    NSMutableString *output = [[NSMutableString alloc] initWithFormat:@"ItemGroup: %@:\n",name];
    
    for (Item *anItem in listOfItems) {
        [output appendFormat:@"%@\n",[anItem descriptionWithIndent:1]];
    }
    
    return output;
}

-(BOOL) satisfied
{
    for (Item *eachItem in [parentCombo listOfAssociatedItems]) {
        if ([self containsItem:eachItem]) {
            return YES;
        }
    }
    return NO;
}


@end
