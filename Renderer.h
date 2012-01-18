//
//  Renderer.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//Renderes are meant to be initialized by being passed a model object and setting themselves
//up accordingly. They have no knowledge of what to do in the case of actions such as clicks
//and switch changes. It is up to the associated view controller to delegate such things.

//It is also the job of the view controller to instantiate the renderer and link it with the view.

//The render acts as the data source for the associated view, and must reflect the state of the associated 
//model after having a call made to redraw

//For the moment, there's nothing that makes a Renderer special as a parent class, but this
//may change in the future.

#import <Foundation/Foundation.h>

@interface Renderer : NSObject

@end
