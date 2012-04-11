//
//  FancyNavigationController.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-04-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FancyNavigationController.h"

@implementation FancyNavigationController

-(id)initWithRootViewController:(UIViewController*)rootViewController{
    if(self = [super initWithRootViewController:rootViewController]){
        UINavigationBar* navbar = [self navigationBar];
        [navbar setBackgroundImage:[UIImage imageNamed:@"BlankTopbarWithShadow.png"] forBarMetrics:UIBarMetricsDefault];
        [navbar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont fontWithName:@"Optima-ExtraBlack" size:22], UITextAttributeFont, 
                                        [UIColor whiteColor], UITextAttributeTextColor,
                                        nil]];
    }
    return self;
}

@end
