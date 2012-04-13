//
//  ShinyTelephoneNumberCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"

@interface ShinyTelephoneNumberCell : CustomViewCell
{
    NSString *theNumber;
    UIButton *theNumberButton;
}

-(void)updateCell;

@end
