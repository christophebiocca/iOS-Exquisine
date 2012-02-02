//
//  IndicatorView.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    IndicatorViewOff = 0, //Green light
    IndicatorViewStale, //Yellow light
    IndicatorViewOn //Red light;
} IndicatorViewState;

@interface IndicatorView : UIImageView
{
    IndicatorViewState state;
}

-(void) setState:(IndicatorViewState)viewState;

@end
