//
//  CustomViewCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//

#import <UIKit/UIKit.h>

@interface CustomViewCell : UITableViewCell
   
+(CustomViewCell *) customViewCellFromData:(id)data;

+(NSString *) cellIdentifierForData:(id)data;

+(BOOL) canDisplayData:(id)data;

+(NSString*) cellIdentifier;

+(UITableViewCellStyle) cellStyle;


-(id) init;

-(void) setData:(id)data;

@end
