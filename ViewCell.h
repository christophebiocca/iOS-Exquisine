//
//  ViewCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"

@interface ViewCell : CustomViewCell
{
    UIView *internalView;
}

-(void) updateCell;

@end
