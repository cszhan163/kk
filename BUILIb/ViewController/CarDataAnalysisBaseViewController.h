//
//  CarDataAnalysisBaseViewController.h
//  BodCarManger
//
//  Created by cszhan on 13-10-2.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "UIBaseViewController.h"
#import "NENavItemController.h"
#import "BaoCarNetBaseViewController.h"
#import "UISimpleNetBaseViewController.h"
@protocol CarDataAnalysisBaseViewControllerDataSouceDelegate;
@interface CarDataAnalysisBaseViewController : UISimpleNetBaseViewController{
    @public
    NENavItemController *navItemCtrl;
    //DateStruct   *mCurrDate;
}
@property(nonatomic,assign)DateStruct   mCurrDate;
@property(weak)id<CarDataAnalysisBaseViewControllerDataSouceDelegate> dataSouce;
- (void)setNeedDisplaySubView;
- (void)selectTopNavItem:(id)navObj;
@end
@protocol CarDataAnalysisBaseViewControllerDataSouceDelegate<NSObject>
@required
//-(NSInteger)tabBarItemCount:(NTESMBMainMenuController*)controller ;
-(NSArray*)viewControllersForNavItemController:(CarDataAnalysisBaseViewController*)controller;
-(NETopNavBar*)topNavBarForNavItemController:(CarDataAnalysisBaseViewController*)controller;
@end