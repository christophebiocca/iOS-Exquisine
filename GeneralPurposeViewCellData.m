//
//  GeneralPurposeViewCellData.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeneralPurposeViewCellData.h"

@implementation GeneralPurposeViewCellData
@synthesize title;
@synthesize description;
@synthesize titleFont;
@synthesize descriptionFont;

-(id)init
{
    self = [super init];
    
    if(self)
    {
        title = @"";
        description = @"";
        titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
        descriptionFont = [UIFont fontWithName:@"HelveticaNeue" size:13];
    }
    
    return self;
}

@end
