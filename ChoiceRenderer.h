//
//  ChoiceRenderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponentRenderer.h"
@class Choice;

@interface ChoiceRenderer : MenuComponentRenderer
{
    Choice *choiceInfo;
    
}

-(ChoiceRenderer *) initWithChoice:(Choice *) aChoice;

-(UITableViewCell *) configureCell:(UITableViewCell *) aCell;

-(NSArray *) detailedStaticRenderList;

@end
