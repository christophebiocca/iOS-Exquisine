//
//  ShinyDeleteCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"

@interface ShinyDeleteCell : CustomViewCell
{
    NSDictionary *deleteTitleInfo;
    UIImageView *cellImage;
    UILabel *deleteLabel;
}

-(void) updateCell;

@end
