//
//  ListViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListViewController.h"
#import "ListRenderer.h"
#import "ExpandableCell.h"

@implementation ListViewController

-(id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) 
    {
        theTableView = [[UITableView alloc] init];
        [theTableView setDelegate:self];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [[[self navigationController] navigationBar] setBackgroundImage:[UIImage imageNamed:@"BlankTopbarWithShadow.png"] forBarMetrics:UIBarMetricsDefault];
    UILabel *toolbarText = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                     ([[[self navigationController] navigationBar] frame ].size.width - 300) / 2,
                                                                     (44 - 30) / 2, 
                                                                     300, 
                                                                     30)];
    [toolbarText setFont:[UIFont fontWithName:@"Optima-ExtraBlack" size:22]];
    [toolbarText setTextColor:[UIColor whiteColor]];
    [toolbarText setBackgroundColor:[UIColor clearColor]];
    [toolbarText setTextAlignment:UITextAlignmentCenter];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellClassName = [CustomViewCell cellIdentifierForData:[renderer objectForCellAtIndex:indexPath]];
    
    SEL aSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@",cellClassName,@"Handler:"]);
    
    if ([self respondsToSelector:aSelector]) {
        [self performSelector:aSelector withObject:indexPath];
    }
    
    if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[ExpandableCell class]])
    {
        [(ExpandableCell *)[tableView cellForRowAtIndexPath:indexPath] toggleOpen:indexPath :tableView];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CustomViewCell cellHeightForData:[renderer objectForCellAtIndex:indexPath]];
}

-(void)loadView
{
    [super loadView];
    [self setView:theTableView];
}

@end
