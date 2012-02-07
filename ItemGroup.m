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
@synthesize satisfied;

-(ItemGroup *)init
{
    self = [super init];
    
    listOfItems = [[NSMutableArray alloc] initWithCapacity:0];
    satisfied = NO;
    
    return self;
}

-(ItemGroup *)initWithDataAndParentMenu:(NSDictionary *)inputData :(Menu *)parentMenu
{
    self = [super initFromData:inputData];
    
    listOfItems = [[NSMutableArray alloc] initWithCapacity:0];
        
    NSMutableArray *itemPKs = [inputData objectForKey:@"items"];
    NSMutableArray *menuPKs = [inputData objectForKey:@"menus"] ;
    
    for (NSString *itemPK in itemPKs) 
    {
        NSInteger intItemPK = [itemPK intValue];
        Item *itemToAdd = [parentMenu dereferenceItemPK:intItemPK];
        if (itemToAdd) {
            [listOfItems addObject:itemToAdd];
        }
        else
        {
            NSLog(@"ERROR: A dereference was attempted on an invalid item PK %i\n%@",intItemPK,parentMenu);
        }
        
    }
    
    for (NSString *menuPK in menuPKs)
    {
        Menu *menuForPK = [parentMenu dereferenceMenuPK:[menuPK intValue]];
        if (menuForPK) {
            [listOfItems addObjectsFromArray:[menuForPK flatItemList]];
        }
        else
        {
            NSLog(@"ERROR: A dereference was attempted on an invalid menu PK %@\n%@",menuPK,parentMenu);
        }
    }
    
    return self;
    
}

- (MenuComponent *)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        listOfItems = [decoder decodeObjectForKey:@"list_of_items"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Rinse and repeat this:
    [super encodeWithCoder:encoder];    
    [encoder encodeObject:listOfItems forKey:@"list_of_items"];
}

-(ItemGroup *)copy
{
    ItemGroup *anItemGroup = [[ItemGroup alloc] init];
    
    anItemGroup->listOfItems = [[NSMutableArray alloc] initWithArray:listOfItems];
    
    anItemGroup->satisfied = satisfied;
    
    return anItemGroup;
    
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

- (NSString *) descriptionWithIndent:(NSInteger) indentLevel
{    
    NSString *padString = [@"" stringByPaddingToLength:(indentLevel*4) withString:@" " startingAtIndex:0];
    
    NSMutableString *output = [[NSMutableString alloc] initWithCapacity:0];
    
    [output appendFormat:@"%@ItemGroup:%\n",padString];
    [output appendString:[super descriptionWithIndent:indentLevel]];
    [output appendFormat:@"%@Satisfied: %i\n",padString,satisfied];
    [output appendFormat:@"%@Items:\n",padString];
    
    for (Item *anItem in listOfItems) {
        [output appendFormat:@"%@\n",[anItem descriptionWithIndent:(indentLevel + 1)]];
    }
    
    return output;
}




@end
