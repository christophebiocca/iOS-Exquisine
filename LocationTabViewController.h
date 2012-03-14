//
//  LocationTabViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-01.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LocationTabView;
@class LocationState;

@interface LocationTabViewController : UIViewController
{
    LocationTabView *locationTabView;
}

- (id)initWithLocationState:(LocationState *) locationState;

@end
