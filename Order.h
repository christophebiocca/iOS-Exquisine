//
//  Order.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuComponent.h"
@class Item;
@class Menu;
@class Combo;
@class Location;
@class PaymentInfo;
@class PaymentSuccessInfo;

#ifdef DEBUG
#define DEFAULT_PITA_PREP_TIME @"20"
#else
#define DEFAULT_PITA_PREP_TIME @"300"
#endif


extern NSString* ORDER_ITEMS_MODIFIED;
extern NSString* ORDER_COMBOS_MODIFIED;
extern NSString* ORDER_FAVORITE_MODIFIED;
extern NSString* ORDER_MODIFIED;

@interface Order : MenuComponent {
    @protected

    BOOL isFavorite;
    
    NSMutableArray *itemList; 
    
    NSMutableArray *comboList;
    
    NSString *status;
    
    NSString *orderIdentifier;
    
    NSDate *creationDate;
    
    NSDate *mostRecentSubmitDate;
    
    NSDate *pitaFinishedTime;
    
    PaymentSuccessInfo *successInfo;
    
}

@property (nonatomic,readonly) BOOL isFavorite;
@property (retain) NSMutableArray* itemList;
@property (retain) NSMutableArray* comboList;
@property (retain) NSString *status;
@property (retain) NSString *orderIdentifier;
@property (readonly) NSDate *creationDate;
@property (readonly) NSDate *mostRecentSubmitDate;
@property (retain) NSDate *pitaFinishedTime;
@property (readonly) PaymentSuccessInfo *successInfo;
@property(readonly)NSDecimalNumber* subtotalPrice;
@property(readonly)NSDecimalNumber* taxPrice;
@property(readonly)NSDecimalNumber* totalPrice;

//Initializers
-(Order *)init;

- (Order *)initWithCoder:(NSCoder *)decoder;

- (void)encodeWithCoder:(NSCoder *)encoder;

-(Order *)copy;

//Access Methods
-(NSString *) defaultFavName;

-(BOOL) containsExactItem:(Item *) anItem;

//Mutation Methods
-(void) addItem:(Item *) anItem;

-(void) removeItem:(Item *) anItem;

-(void)removeListOfItems:(NSMutableArray *)aListOfItems;

-(void) addCombo:(Combo *) aCombo;

-(void) removeCombo:(Combo *) aCombo;

-(void) setFavorite:(BOOL)isfav;

-(void)placedWithTransactionInfo:(PaymentSuccessInfo*)info;

-(void)submit;

-(void)setComplete;

//Housekeeping Methods
-(void) recalculate:(NSNotification *) aNotification;

//Comparitor and Descriptor Methods

-(BOOL) isEffectivelyEqual:(id) anOrder;

-(NSDictionary*)orderRepresentation;

-(NSString *) descriptionWithIndent:(NSInteger) indentLevel;

@end
