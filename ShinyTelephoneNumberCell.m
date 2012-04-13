//
//  ShinyTelephoneNumberCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyTelephoneNumberCell.h"

@implementation ShinyTelephoneNumberCell

-(id)init
{
    self = [super init];
    if (self) {
        theNumberButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [theNumberButton addTarget:self action:@selector(callNumber) forControlEvents:UIControlEventTouchUpInside];
        [[theNumberButton titleLabel] setFont:[UIFont fontWithName:@"AmericanTypewriter" size:14]];
        [theNumberButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [theNumberButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        [theNumberButton setFrame:CGRectMake(10, 1, 200, 21)];
        
        [self addSubview:theNumberButton];
    }
    return self;
}

+(BOOL) canDisplayData:(id)data
{
    //Returns true iff the data passed in is meant to be displayed by this cell.
    
    if ([data isKindOfClass:[NSDictionary class]] && [data objectForKey:@"telephoneNumber"]) {
        return YES;
    }
    return NO;
}

+(NSString *) cellIdentifier
{
    //Must return a unique string identifier for this type of cell.
    return @"ShinyTelephoneNumberCell";
}



-(void) setData:(id) data
{
    if (![[self class] canDisplayData:data])
    {
        CLLog(LOG_LEVEL_ERROR, @"An unsupported data type was sent to ShinyTelephoneNumberCell's setData:");
        return;
    }
    
    theNumber = [data objectForKey:@"telephoneNumber"];
    [self updateCell];
}

-(void) updateCell
{
    [theNumberButton setTitle:theNumber forState:UIControlStateNormal];
    //Any of the changed associated with the data input in setData should occur here.
    
    //If the data is prone to changing, this cell should call updateCell via an NSNotificationCenter.
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

+(CGFloat)cellHeightForData:(id)data
{
    return 22;
}

-(void)callNumber
{
    NSString *callToURLString = [NSString stringWithFormat:@"tel:%@",theNumber ];
    if (![[UIApplication sharedApplication] openURL:[NSURL URLWithString:callToURLString]])
	{
		CLLog(LOG_LEVEL_ERROR, @"There was an error trying to dial a number =(");
	}
}

@end
