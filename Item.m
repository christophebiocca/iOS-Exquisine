//
//  Item.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Item.h"
#import "Option.h"	
#import "TableData.h"
#import "CellData.h"
#import "Utilities.h"

@implementation Item

/* 
 **************************************************************************
 *
 *      Standard Class Functions
 *
 **************************************************************************
 */

@synthesize options;

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@, C%i, with options: %@", name, basePriceCents, options];
}

/* 
 **************************************************************************
 *
 *      View Managing Functions
 *
 **************************************************************************
 */



-(void) initializeTableData
{
    tableData = [[TableData alloc] initWithOwner:self];
    [tableData setTableName:name];
    [tableData setCellDataList:options];
}

-(void) initializeCellData
{
    cellData = [[CellData alloc] initWithOwner:self];
    [cellData setCellTitle:name];
    [cellData setCellDesc:[Utilities FormatToPrice:basePriceCents]];
}

/* 
 **************************************************************************
 *
 *      Custom Class Functions
 *
 **************************************************************************
 */

-(id)initWithNavigationController:(UINavigationController *) aController
{
    options = [[NSMutableArray 	alloc] initWithCapacity:0];
    self = [super initWithNavigationController:aController];
    return self;
}

-(void) setBasePrice:(NSInteger) anInt
{
    basePriceCents = anInt;
    [cellData setCellDesc:[Utilities FormatToPrice:anInt]];
}

-(void)addOption:(Option *)anOption
{
    [options addObject:anOption];
}

-(void) setName:(NSString *)aName
{
    name = aName;
    [tableData setTableName:aName];
    [cellData setCellTitle:aName];
}

-(void) setDesc:(NSString *)aDesc
{
    desc = aDesc;
    [cellData setCellDesc:aDesc];
}

-(NSInteger)totalPrice
{
    NSInteger tabulation = basePriceCents;
    
    for (Option *currentOption in options) 
    {
        tabulation += currentOption.totalPrice;
    }
    
    NSLog(@"The price found was: %i", tabulation);
    return tabulation;
}

@end
