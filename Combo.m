//
//  Combo.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Combo.h"
#import "Item.h"
#import "Order.h"
#import "Menu.h"
#import "ItemGroup.h"
#import "ComboPricingStrategy.h"
#import "ComboTrivialPricingStrategy.h"

NSString* COMBO_MODIFIED = @"CroutonLabs/ComboModified";


@implementation Combo

@synthesize listOfItemGroups;

-(Combo *)init
{
    self = [super init];
    
    listOfItemGroups = [[NSMutableArray alloc] initWithCapacity:0];
    strategy = [[ComboTrivialPricingStrategy alloc] init];
    
    return self;
}

-(Combo *)initFromDataAndMenu:(NSDictionary *)inputData:(Menu *) associatedMenu
{
    self = [super initFromData:inputData];
    
    listOfItemGroups = [[NSMutableArray alloc] initWithCapacity:0];
    
    strategy = [ComboPricingStrategy pricingStrategyFromData:[inputData objectForKey:@"pricing_strategy"]];
    
    if(!strategy)
    {
        CLLog(LOG_LEVEL_WARNING, @"an invalid stratagy string was parsed from JSON data");
    }
    
    for (NSDictionary *componentInfo in [inputData objectForKey:@"components"]) {
        ItemGroup *newItemGroup = [[ItemGroup alloc] initWithDataAndParentMenu:componentInfo :associatedMenu];
        [listOfItemGroups addObject:newItemGroup];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recalculate:) name:ITEM_GROUP_MODIFIED object:newItemGroup];
        
    }
    
    return self;
}

- (MenuComponent *)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        
        listOfItemGroups = [decoder decodeObjectForKey:@"list_of_item_groups"];
        
        for (ItemGroup *newItemGroup in listOfItemGroups) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recalculate:) name:ITEM_GROUP_MODIFIED object:newItemGroup];
        }
        
        strategy = [decoder decodeObjectForKey:@"strategy"];
        
        if ((!strategy) || (!listOfItemGroups))
        {
            CLLog(LOG_LEVEL_ERROR, [NSString stringWithFormat: @"Combo failed to load properly from harddisk: \n%@" , self]);
        }
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Rinse and repeat this:
    [super encodeWithCoder:encoder];
    [encoder encodeObject:listOfItemGroups forKey:@"list_of_item_groups"];
    [encoder encodeObject:strategy forKey:@"strategy"];
}

- (Combo *)copy
{
    Combo *aCombo = [[Combo alloc] init];
    
    aCombo->name = name;
    aCombo->desc = desc;
    aCombo->primaryKey = primaryKey;
    
    for (ItemGroup *anItemGroup in listOfItemGroups) {
        ItemGroup *newItemGroup = [anItemGroup copy];
        [[aCombo listOfItemGroups] addObject:newItemGroup];
        [[NSNotificationCenter defaultCenter] addObserver:aCombo selector:@selector(recalculate:) name:ITEM_GROUP_MODIFIED object:newItemGroup];
    }
    
    //doesnt need to be copied
    aCombo->strategy = strategy;
    
    return aCombo;
}

//Just placeholders****************V

-(NSArray *)satisfactionListsForItemList:(NSArray *)anItemList
{
    NSMutableArray *returnList = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (ItemGroup *anItemGroup in listOfItemGroups) {
        NSMutableArray *newSublist = [[NSMutableArray alloc] initWithCapacity:0];
        
        for (Item *eachItem in anItemList) {
            if ([anItemGroup containsItem:eachItem]) {
                [newSublist addObject:eachItem];
            }
        }
        
        [returnList addObject:newSublist];
    }
    
    return returnList;
}

-(NSArray *)listOfAssociatedItems
{
    NSMutableArray *output = [[NSMutableArray alloc] initWithCapacity:[listOfItemGroups count]];
    for (ItemGroup *eachItemGroup in listOfItemGroups) {
        if ([eachItemGroup satisfied]) {
            [output addObject:[eachItemGroup satisfyingItem]];
        }
    }
    return output;
}

-(NSDecimalNumber *)price
{
    return [strategy priceForItemGroups:listOfItemGroups];
}

-(NSDecimalNumber *)savings{
    NSDecimalNumber* oldTotal = [NSDecimalNumber zero];
    for(Item* item in [self listOfAssociatedItems]){
        oldTotal = [oldTotal decimalNumberByAdding:[item price]];
    }
    return [oldTotal decimalNumberBySubtracting:[self price]];
}

-(BOOL)satisfiedWithItemList:(NSArray *)anItemList
{
    //This is pretty inefficient, but let's see if it will work. It might.
    
    NSMutableArray *helperList = [[NSMutableArray alloc] initWithArray:anItemList];
    
    for (ItemGroup *anItemGroup in listOfItemGroups) {
        BOOL satisfiedYet = NO;
        for (Item *anItem in [NSArray arrayWithArray: helperList]) {
            if (![anItemGroup satisfied]) {
                if ([anItemGroup containsItem:anItem]) {
                    satisfiedYet = YES;
                    [helperList removeObject:anItem];
                }
            }
        }
        if (!satisfiedYet)
            return NO;
    }
    
    return YES;
    
}

-(BOOL)containsItem:(Item *)anItem
{
    for (ItemGroup *eachItemGroup in listOfItemGroups) {
        if ([[eachItemGroup satisfyingItem] isEffectivelyEqual:anItem]) {
            return YES;
        }
    }
    return NO;
}

-(BOOL)containsExactItem:(Item *)anItem
{
    for (ItemGroup *eachItemGroup in listOfItemGroups) {
        if ([[eachItemGroup satisfyingItem] isEqual:anItem]) {
            return YES;
        }
    }
    return NO;
}

-(BOOL)satisfied
{
    for (ItemGroup *anItemGroup in listOfItemGroups) {
        if (![anItemGroup satisfied]) {
            return NO;
        }
    }
    return YES;
}

-(NSDecimalNumber *)savingsMagnitude
{
    NSDecimalNumber *tally = [[NSDecimalNumber alloc] initWithInt:0];
    
    //This actually makes the assumption that each item in the item group costs the same price. This
    //may not be true in all cases, but I think it is for pita factory.
    for (ItemGroup *anItemGroup in listOfItemGroups) {
        [tally decimalNumberByAdding:[[[anItemGroup listOfItems] objectAtIndex:0] price]];
    }
    
    [tally decimalNumberBySubtracting:[self price]];
    
    return tally;
}

-(void)addItem:(Item *)anItem
{
    for (ItemGroup *eachItemGroup in listOfItemGroups) {
        if((![eachItemGroup satisfied])&&([eachItemGroup containsItem:anItem]))
        {
            [eachItemGroup setSatisfyingItem:anItem];
            [self recalculate:nil];
            return;
        }
    }
}

-(void)removeItem:(Item *)anItem
{
    for (ItemGroup *eachItemGroup in listOfItemGroups) {
        if(([eachItemGroup satisfied])&&([eachItemGroup containsItem:anItem]))
        {
            [eachItemGroup setSatisfyingItem:[[Item alloc] init]];
            [self recalculate:nil];
            return;
        }
    }
}

-(void)removeAllItems
{
    for (ItemGroup *eachItemGroup in listOfItemGroups) {
        [eachItemGroup setSatisfyingItem:[[Item alloc] init]];
    }
    [self recalculate:nil];
}

-(void)recalculate:(NSNotification *)aNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:COMBO_MODIFIED object:self];
}

-(BOOL) isEffectivelyEqual:(Combo *) anotherCombo
{
    return ([anotherCombo.name isEqualToString:name]);
}

-(NSComparisonResult)savingsSort:(Combo *)aCombo
{
    return [[aCombo savingsMagnitude] compare:[self savingsMagnitude]];
}

-(Combo*)optimalPickFromItems:(NSArray *)items{
    NSArray* satisfyingItems = [strategy optimalPickFromItems:items usingItemGroups:listOfItemGroups];
    if(!satisfyingItems){
        return nil;
    }
    Combo* new = [self copy];
    [new removeAllItems];
    [new setListOfItemGroups:[NSMutableArray arrayWithArray:satisfyingItems]];
    [new recalculate:nil];
    return new;
}

-(NSString *) descriptionWithIndent:(NSInteger) indentLevel
{
    NSString *padString = [@"" stringByPaddingToLength:(indentLevel*4) withString:@" " startingAtIndex:0];
    
    NSMutableString *output = [[NSMutableString alloc] initWithCapacity:0];
    
    [output appendFormat:@"%@Combo:\n",padString];
    [output appendFormat:@"%@Pricing strategy: %@ \n", padString, strategy];
    [output appendString:[super descriptionWithIndent:indentLevel]];
    [output appendFormat:@"%@ItemGroups:\n",padString];
    
    for (ItemGroup *anItemGroup in listOfItemGroups) {
        [output appendFormat:@"%@\n",[anItemGroup descriptionWithIndent:(indentLevel + 1)]];
    }
    
    return output;
}

-(NSDictionary*)orderRepresentation{
    NSMutableArray* components = [NSMutableArray arrayWithCapacity:[listOfItemGroups count]];
    for(ItemGroup* group in listOfItemGroups){
        [components addObject:[group orderRepresentation]];
    }
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithUnsignedInteger:primaryKey], @"combo",
            components, @"components",
            nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
