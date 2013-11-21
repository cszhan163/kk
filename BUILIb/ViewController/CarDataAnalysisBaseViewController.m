//
//  CarDataAnalysisBaseViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-10-2.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarDataAnalysisBaseViewController.h"



#define kLeftPendingX  10
#define kTopPendingY  8
#define kHeaderItemPendingY 8

@interface CarDataAnalysisBaseViewController ()

//@property(nonatomic,weak)id<CarDataAnalysisBaseViewControllerDelegate> dataSouce;
@end

@implementation CarDataAnalysisBaseViewController
@synthesize dataSouce;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.dataSouce = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    [self setHiddenLeftBtn:YES];
     */
    [self setHiddenRightBtn:YES];
    
  
    //self.view.backgroundColor = [UIColor clearColor];
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"car_bg.png");
    mainView.bgImage = bgImage;
    
    UIImageWithFileName(bgImage, @"car_plant_bg.png");
    UIImageView *tableViewBg = [[UIImageView alloc]initWithImage:bgImage];
    [self.view  addSubview:tableViewBg];
      
     tableViewBg.frame = CGRectMake(kLeftPendingX,kMBAppTopToolBarHeight+kTopPendingY,kDeviceScreenWidth-2*kLeftPendingX,bgImage.size.height/kScale);
    tableViewBg.clipsToBounds = YES;
    
    tableViewBg.clipsToBounds = YES;
    tableViewBg.userInteractionEnabled = YES;
     
    navItemCtrl = [[NENavItemController alloc]init];
    //self.dataSouce = self;
    //navItemCtrl.toolbarItems =
    NSArray *vcArray = [self.dataSouce viewControllersForNavItemController:self];
    navItemCtrl.navControllersArr = vcArray;
    
    NETopNavBar *topNavBar = [self.dataSouce topNavBarForNavItemController:self];
    
   //
    //topNavBar.delegate = navItemCtrl;
    
    [tableViewBg addSubview:navItemCtrl.view];
    navItemCtrl.view.frame = CGRectMake(0.f,-20.f,kDeviceScreenWidth,kDeviceScreenHeight-kMBAppStatusBar-kMBAppBottomToolBarHeght-kMBAppTopToolBarHeight);
#if 1
    [tableViewBg addSubview:topNavBar];
    SafeRelease(topNavBar);
    //topNavBar.hidden = YES;
    [navItemCtrl setTopNavBar:topNavBar];
    //topNavBar.frame = CGRectOffset(topNavBar.frame, 0.f,kMBAppTopToolBarHeight);
    [topNavBar didNavItemSelect:[topNavBar.navBtnArray objectAtIndex:0]];
#endif
    [self.view bringSubviewToFront:mainView.topBarView ];
    [self setNeedDisplaySubView];
    [self loadAnalaysisData];
	// Do any additional setup after loading the view.
}
- (void)selectTopNavItem:(id)navObj{
    [navItemCtrl didSelectorTopNavItem:navObj];
}
- (void)setNeedDisplaySubView{

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
