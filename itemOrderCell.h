//
//  itemOrderCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Item;

@interface ItemOrderCell : UITableViewCell
{
    Item* item;
    UIImage* deleteImage;
}

@property(nonatomic,retain)Item* item;

+(NSString*)cellIdentifier;
-(id)init;



@end
