//
//  ListViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListRenderer;

@interface ListViewController : UIViewController <UITableViewDelegate>
{
    UITableView *theTableView;
    //Note that it is the responsibility of the subclass to
    //initialize an appropriate list renderer subclass and 
    //suff it in this guy:
    ListRenderer *renderer;
}

@end
