//
//  IndicatorView.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IndicatorView.h"



@implementation IndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setState:IndicatorViewOff];
    }
    return self;
}

-(void)layoutSubviews
{
    [self setImage:[UIImage imageNamed:@"IndicatorImageOff.png"]];
}

-(void)setState:(IndicatorViewState)viewState
{
    state = viewState;
    switch (state) {
        case IndicatorViewOn:
            [self setImage:[UIImage imageNamed:@"IndicatorImageOn.png"]];
            break;
        case IndicatorViewStale:
            [self setImage:[UIImage imageNamed:@"IndicatorImageStale.png"]];
            break;
        case IndicatorViewOff:
            [self setImage:[UIImage imageNamed:@"IndicatorImageOff.png"]];
            break;
            
        default:
            break;
    }
}

@end
