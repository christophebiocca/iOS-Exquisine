//
//  ExpandableCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExpandableCell.h"
#import "ExpandableCellData.h"
#import "ListRenderer.h"

@implementation ExpandableCell

-(id)init
{
    self = [super init];
    
    if (self) {
        colapsedImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ColapsedMenuDropdown.png"]];
        expandedImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ExpandedMenuDropdown.png"]];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(93, 26, 120, 21)];
        [nameLabel setFont:[Utilities fravicHeadingFont]];
        [nameLabel setTextAlignment:UITextAlignmentCenter];
        [nameLabel setTextColor:[UIColor blackColor]];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setAdjustsFontSizeToFitWidth:YES];
        numberOfItemsLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 50, 100, 21)];
        [numberOfItemsLabel setFont:[Utilities fravicTextFont]];
        [numberOfItemsLabel setTextColor:[Utilities fravicDarkRedColor]];
        [numberOfItemsLabel setBackgroundColor:[UIColor clearColor]];
        [numberOfItemsLabel setTextAlignment:UITextAlignmentRight];
                
        [self addSubview:colapsedImage];
        [self addSubview:expandedImage];
        [self addSubview:nameLabel];
        [self addSubview:numberOfItemsLabel];
    }
    
    return self;
}

+(BOOL) canDisplayData:(id)data
{
    //This class is meant to be subclassed. If this were ever true, the subclasses
    //wouldn't be instantiated by CustomViewCell.
    return NO;
}

+(NSString *) cellIdentifier
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
    //Must return a unique string identifier for this type of cell.
    return @"ExpandableCell";
}

-(void) setData:(id) data
{
    //In theory this will never actually get called.
    if (![[self class] canDisplayData:data])
    {
        CLLog(LOG_LEVEL_ERROR, @"An unsupported data type was sent to ExpandableCell's setData:");
        return;
    }
    
    expandableData = data;
    
    if ([data isOpen]) {
        [self initializeOpen];
    }
    else {
        [self initializeClosed];
    }
    
}

+(CGFloat)cellHeightForData:(id)data
{
    if ([data isOpen]) {
        return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ExpandedMenuDropdown.png"]] frame].size.height;
    }
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ColapsedMenuDropdown.png"]] frame].size.height;
}

-(void)transitionToOpen:(NSIndexPath *) selfLocation :(UITableView *)table
{
    if (![expandableData isOpen]) {
        [expandableData setIsOpen:YES];
        //Replace this cell with one that's open
        [[[[expandableData renderer] listData] objectAtIndex:[selfLocation section]] replaceObjectAtIndex:[selfLocation row] withObject:expandableData];
        
        //Reload the cell so that the new open cell gets displayed
        [table reloadRowsAtIndexPaths:[NSArray arrayWithObject:selfLocation] withRowAnimation:UITableViewRowAnimationFade];
        
        //Now we need to insert all of the expansion contents into the renderer:
        
        NSMutableArray *helperArray = [[NSMutableArray alloc] init];
        
        for (int i=1; i<([[expandableData expansionContents] count] + 1); i++)
        {
            NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:(selfLocation.row + i) inSection:selfLocation.section];
            [helperArray addObject:tmpIndexPath];
        }
        
        int i = [selfLocation row] + 1;
        
        for (id eachItem in [expandableData expansionContents]) {
            [[[[expandableData renderer] listData] objectAtIndex:[selfLocation section]] insertObject:eachItem atIndex:i];
            i++;
        }
        
        [table insertRowsAtIndexPaths:helperArray withRowAnimation:UITableViewRowAnimationTop];
        [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[selfLocation row] inSection:[selfLocation section]] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }
    else {
        CLLog(LOG_LEVEL_ERROR, @"A transition to open was attempted on an expandable cell that is already open.");
    }
    
}

-(void)transitionToClosed:(NSIndexPath *) selfLocation:(UITableView *)table
{
    if ([expandableData isOpen]) {
        [expandableData setIsOpen:NO];
        
        //Replace this cell with one that's closed
        [[[[expandableData renderer] listData] objectAtIndex:[selfLocation section]] replaceObjectAtIndex:[selfLocation row] withObject:expandableData];
        
        //Reload the cell so that the new open cell gets displayed
        [table reloadRowsAtIndexPaths:[NSArray arrayWithObject:selfLocation] withRowAnimation:UITableViewRowAnimationFade];
        
        //Now we need to remove all of the cells that are associated with this expandable cell
        NSMutableArray *helperArray = [[NSMutableArray alloc] init];
        
        for (int i=1; i<([[expandableData expansionContents] count] + 1); i++)
        {
            NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:(selfLocation.row + i) inSection:selfLocation.section];
            [helperArray addObject:tmpIndexPath];
        }

        for (id eachItem in [expandableData expansionContents]) {
            
            [[[[expandableData renderer] listData] objectAtIndex:[selfLocation section]] removeObjectAtIndex:([selfLocation row] + 1)];
        }
        
        [table deleteRowsAtIndexPaths:helperArray withRowAnimation:UITableViewRowAnimationTop];
    }
    else {
        CLLog(LOG_LEVEL_ERROR, @"A transition to closed was attempted on an expandable cell that is already closed.");
    }
}

-(void)toggleOpen:(NSIndexPath *)selfLocation :(UITableView *)table
{
    if ([expandableData isOpen]) {
        [self transitionToClosed:selfLocation :table];
    }
    else {
        [self transitionToOpen:selfLocation :table];
    }
}

-(void)initializeOpen
{
    [nameLabel setAlpha:1.0f];
    [numberOfItemsLabel setAlpha:0.0f];
    [colapsedImage setAlpha:0.0f];
    [expandedImage setAlpha:1.0f];
}

-(void)initializeClosed
{
    [nameLabel setAlpha:1.0f];
    [numberOfItemsLabel setAlpha:1.0f];
    [colapsedImage setAlpha:1.0f];
    [expandedImage setAlpha:0.0f];
}

@end
