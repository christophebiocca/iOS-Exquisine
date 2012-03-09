//
//  OpeningHours.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AutomagicalCoder.h"

@interface OpeningHours : AutomagicalCoder{
    NSInteger day;
    BOOL isOpen;
    NSDateComponents* opens;
    NSDateComponents* closes;
}

-(id)initWithData:(NSDictionary*)data day:(NSString*)dayName;

@property(readonly)BOOL isOpen;
@property(retain,readonly)NSDateComponents* opens;
@property(retain,readonly)NSDateComponents* closes;

@end
