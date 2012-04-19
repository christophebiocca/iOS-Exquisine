//
//  ListViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListRenderer;

@interface ListViewController : UIViewController <UITableViewDelegate>
{
    UITableView *theTableView;
    //Note that it is the responsibility of the subclass to
    //initialize an appropriate list renderer subclass and 
    //suff it in this guy:
    ListRenderer *renderer;
}

//Every time a cell type is added, it should go here.
//(assuming its something that you need to know if it gets
//clicked on)

-(void)ShinyPaymentViewCellHandler:(NSIndexPath *) indexPath;
-(void)ShinyDeleteCellHandler:(NSIndexPath *) indexPath;
-(void)ShinyOrderHistoryCellHandler:(NSIndexPath *) indexPath;
-(void)ShinyComboFavoriteCellHandler:(NSIndexPath *) indexPath;
-(void)ShinySettingsCellHandler:(NSIndexPath *) indexPath;
-(void)ShinyItemFavoriteCellHandler:(NSIndexPath *) indexPath;
-(void)ShinyItemGroupCellHandler:(NSIndexPath *) indexPath;
-(void)ShinyChoiceCellHandler:(NSIndexPath *) indexPath;
-(void)ShinyMenuComboCellHandler:(NSIndexPath *) indexPath;
-(void)ShinyMenuItemCellHandler:(NSIndexPath *) indexPath;
-(void)ShinyOrderComboCellHandler:(NSIndexPath *) indexPath;
-(void)ShinyComboOrderItemCellHandler:(NSIndexPath *) indexPath;
-(void)ShinyOrderItemCellHandler:(NSIndexPath *)indexPath;

@end
