//
//  MainPage.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APICallDelegate.h"

@class MainPageView;
@class Menu;

@interface MainPageViewController : UIViewController<UITableViewDelegate, APICallDelegate>{

    MainPageView *mainPageView;
    Menu *theMenu;
    
    NSMutableArray *ordersHistory;
    NSMutableArray *favoriteOrders;
    
}

-(NSMutableArray *) pendingOrders;

@end
