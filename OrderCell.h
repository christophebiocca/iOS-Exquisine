//
//  OrderCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Order;

@interface OrderCell : UITableViewCell
{
    Order *order;
}

@property (nonatomic,retain) Order *order;

-(id)init;

+(NSString *) cellIdentifier;

@end
