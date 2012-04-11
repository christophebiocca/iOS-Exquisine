//
//  ShinyHeaderView.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShinyHeaderView : UIView
{
    UIImageView *menuHeaderImage;
    UILabel *menuLabel;
}

- (id)initWithTitle:(NSString *) title;

@end
