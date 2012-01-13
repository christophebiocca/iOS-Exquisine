//
//  OrderPage.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Order.h"
#import "OrderPage.h"
#import "OrderPageView.h"
#import "ConfigurableTableViewDataSource.h"
#import "ItemPage.h"
#import "Utilities.h"

@implementation OrderPage

@synthesize currentOrder;

//Custom functions
//***********************************************************

-(void)initializeViewWithOrder:(Order *)anOrder{
    
    currentOrder = anOrder;
    NSMutableArray *cellDataList;
    cellDataList = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (Item *currentItem in anOrder.itemList) {
        
        CellInfo *newCell = [[CellInfo alloc] init];
        newCell.labelText = currentItem.name;
        newCell.descriptionText = [Utilities FormatToPrice:[currentItem totalPrice]];
        [cellDataList addObject:newCell];
        
    }
    
    CellInfo *newCell = [[CellInfo alloc] init];
    newCell.labelText = @"Total:";
    newCell.descriptionText = [Utilities FormatToPrice:[currentOrder totalPrice]];
    [cellDataList addObject:newCell];
    
    CellInfo *secondNewCell = [[CellInfo alloc] init];
    secondNewCell.labelText = @"Add Item";
    [cellDataList addObject:secondNewCell]; 
    
    orderTableDataSource.displayList = cellDataList;
    
}

//Delegate functions
//***********************************************************

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    if ([indexPath row] < [[currentOrder itemList] count]) {
        ItemPage *itemPage = [[ItemPage alloc] init];
        [itemPage initializeViewWithItem:[[currentOrder itemList] objectAtIndex:[indexPath row]]];
        [[super navigationController] pushViewController:itemPage animated:YES];
    }
    
}

//View related functions
//***********************************************************



- (id)init{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        [[self navigationItem] setTitle:@"Your Order"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) loadView
{
    orderPageView = [[OrderPageView alloc] init];
    [self setView:orderPageView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //**********************************************
    //Testing only. This is not how we are going to load menus
    // lol!
    
    currentOrder = [[Order alloc] init];
    
    Choice *lettuce = [[Choice alloc] init];
    
    lettuce.desc = @"Fresh and crunchy romaine lettuce";
    lettuce.name = @"Romaine Lettuce";
    lettuce.normalPriceCents = 50;
    
    Choice *baconBits = [[Choice alloc] init];
    
    baconBits.desc = @"Savory bacon bits";
    baconBits.name = @"Bacon Bits";
    baconBits.normalPriceCents = 20;
    
    Choice *crutons = [[Choice alloc] init];
    
    crutons.desc = @"Crisp, crumbly crutons";
    crutons.name = @"Crutons";
    crutons.normalPriceCents = 25;
    
    Choice *avocado = [[Choice alloc] init];
    
    avocado.desc = @"Thinly sliced fresh avocado";
    avocado.name = @"Avocado";
    avocado.normalPriceCents = 53;
    
    Option *toppings = [[Option alloc] init];
    
    toppings.name = @"Toppings";
    toppings.lowerBound = 0;
    toppings.upperBound = 3;
    toppings.numberOfFreeChoices = 2;
    
    [toppings addPossibleChoice:lettuce];
    [toppings addPossibleChoice:baconBits];
    [toppings addPossibleChoice:avocado];
    [toppings addPossibleChoice:crutons];
    [toppings selectChoice:lettuce];
    [toppings selectChoice:avocado];
    
    Item *chickenCeasar = [[Item alloc] init];
    
    chickenCeasar.name = @"Chicken Ceasar Pita";
    chickenCeasar.basePriceCents = 800;
    chickenCeasar.desc = @"Chicken pita";
    
    [chickenCeasar addOption:toppings];
    
    [currentOrder addItem:chickenCeasar];
    
    Item *chipotle = [[Item alloc] init];
    
    chipotle.name = @"Spicy Chipotle Pita";
    chipotle.basePriceCents = 800;
    chipotle.desc = @"Chicken chipotle with fresh veggies";
    
    [chipotle addOption:toppings];
    
    [currentOrder addItem:chipotle];
    
    [currentOrder addItem:chipotle];
    
    //This currently isn't formatted well, needs fixing.
    NSLog(@"%@", [currentOrder description]);
    
    orderTableDataSource = [[ConfigurableTableViewDataSource alloc] init];
    
    [[orderPageView orderTable] setDelegate:self];
    [[orderPageView orderTable] setDataSource:orderTableDataSource];
    
    [self initializeViewWithOrder: currentOrder];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initializeViewWithOrder:currentOrder];
    [[orderPageView orderTable] reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
     
