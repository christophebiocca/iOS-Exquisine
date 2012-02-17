//
//  OrderCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuCompositeCell.h"

@class Order;

@interface OrderCell : MenuCompositeCell
{
    Order *order;
}

@property (nonatomic,retain) Order *order;

+(NSString *) cellIdentifier;

@end
