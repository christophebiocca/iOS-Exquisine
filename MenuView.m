//
//  MenuView.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

@synthesize menuTable;
@synthesize menuToolBar;
@synthesize cancelButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        menuTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        menuToolBar = [[UIToolbar alloc] init];
        
        cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:sel_registerName("cancelButton")];
    
        [cancelButton setWidth:308];
        [cancelButton setTintColor:[UIColor colorWithRed:235/255.0 green:12/255.0 blue:20/255.0 alpha:230/255.0]];
        
        NSArray *toolbarItems = [NSArray arrayWithObjects: cancelButton, nil];
        [menuToolBar setItems:toolbarItems animated:NO];
        
        
        [self addSubview:menuTable];
        [self addSubview:menuToolBar];
    }
    return self;
}

-(void)layoutSubviews
{
    [menuTable setFrame:CGRectMake(0, 0, 320, 372)];
    [menuToolBar setFrame:CGRectMake(0, 372, 320, 44)];
}


@end
