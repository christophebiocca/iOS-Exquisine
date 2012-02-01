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

@implementation ItemGroup

@synthesize satisfied;

-(ItemGroup *)initWithDataAndParentMenu:(NSDictionary *)inputData:(Menu *) inputMenu
{
    //self = [super initFromData:inputData];

    satisfied = NO;
    
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
        if ([anItem.name isEqual:item.name]) {
            satisfied = YES;
            return YES;
        }
    }
    satisfied = NO;
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
        parentMenu = [decoder decodeObjectForKey:@"parent_menu"];
        listOfItems = [decoder decodeObjectForKey:@"list_of_items"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Rinse and repeat this:
    [super encodeWithCoder:encoder];
    [encoder encodeObject:parentMenu forKey:@"parent_menu"];
    [encoder encodeObject:listOfItems forKey:@"list_of_items"];
}


@end
