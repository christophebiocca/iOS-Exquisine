//
//  ShinyEmailAddressCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyEmailAddressCell.h"

@implementation ShinyEmailAddressCell

-(id)init
{
    self = [super init];
    if (self) {
        theAddressButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [theAddressButton addTarget:self action:@selector(openEmail) forControlEvents:UIControlEventTouchUpInside];
        [[theAddressButton titleLabel] setFont:[UIFont fontWithName:@"AmericanTypewriter" size:14]];
        [theAddressButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [theAddressButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        [theAddressButton setFrame:CGRectMake(10, 1, 200, 21)];
        
        [self addSubview:theAddressButton];
    }
    return self;
}

+(BOOL) canDisplayData:(id)data
{
    //Returns true iff the data passed in is meant to be displayed by this cell.
    
    if ([data isKindOfClass:[NSDictionary class]] && [data objectForKey:@"emailAddress"]) {
        return YES;
    }
    return NO;
}

+(NSString *) cellIdentifier
{
    //Must return a unique string identifier for this type of cell.
    return @"ShinyEmailAddressCell";
}



-(void) setData:(id) data
{
    if (![[self class] canDisplayData:data])
    {
        CLLog(LOG_LEVEL_ERROR, @"An unsupported data type was sent to ShinyEmailAddressCell's setData:");
        return;
    }
    
    theAddress = [data objectForKey:@"emailAddress"];
    [self updateCell];
}

-(void) updateCell
{
    [theAddressButton setTitle:theAddress forState:UIControlStateNormal];
    //Any of the changed associated with the data input in setData should occur here.
    
    //If the data is prone to changing, this cell should call updateCell via an NSNotificationCenter.
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

+(CGFloat)cellHeightForData:(id)data
{
    return 22;
}

-(void)openEmail
{
    NSString *callToURLString = [NSString stringWithFormat:@"mailto:%@",theAddress ];
    if (![[UIApplication sharedApplication] openURL:[NSURL URLWithString:callToURLString]])
	{
		CLLog(LOG_LEVEL_ERROR, @"There was an error trying open the email");
	}
}

@end
