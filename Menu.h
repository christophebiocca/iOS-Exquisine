//
//  Menu.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuComponent.h"
@class Item;
@class Order;
@class Combo;

@interface Menu : MenuComponent<NSCoding>{

    NSMutableArray *submenuList;
    NSMutableArray *comboList;
}

@property (retain,readonly) NSMutableArray *submenuList;
@property (retain,readonly) NSMutableArray *comboList;

//Initializers
-(Menu *) init;

-(Menu *) initFromData:(NSDictionary *)inputData;

-(Menu *) initFromDataAndRootMenu:(NSDictionary *)inputData:(Menu *)theRootMenu;

-(Menu *) copy;

//Access Methods
-(Item *) dereferenceItemPK:(NSInteger) itemPK;

-(Menu *) dereferenceMenuPK:(NSInteger) menuPK;

-(NSArray *) flatItemList;

-(NSArray *) recursiveComboList;

//Mutation Methods
-(void) addItem:(Item *) anItem;

-(void) addSubmenu:(Menu *) aSubmenu;

-(void) addCombo: (Combo *) aCombo;

//Housekeeping Methods

//Comparitor and Descriptor Methods
-(BOOL) isEffectivelyEqual:(id) aMenu;

-(NSString *) descriptionWithIndent:(NSInteger) indentLevel;


@end
