//
//  CarDriveMannerAnalysisViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-10-4.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarDriveMannerAnalysisViewController.h"
#import "DriveActionAnalysisView.h"
#import "UIImageNetBaseViewController.h"
#import "SubNavItemBaseViewController.h"
#import "CarDriveMannerDataViewController.h"
#import "CarDriveOilDataViewController.h"

@interface CarDriveMannerDataGraphViewController:SubNavItemBaseViewController{
    
    DriveActionAnalysisView *dataAnaylsisView;
}
- (void)setNeedDisplaySubView;
@end

@implementation CarDriveMannerDataGraphViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    dataAnaylsisView = [[DriveActionAnalysisView alloc]initWithFrame:CGRectMake(0.f, kMBAppTopToolBarHeight+10.f, 320.f,300)];
    [self.view addSubview:dataAnaylsisView];
    SafeRelease(dataAnaylsisView);
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[dataAnaylsisView setNeedsDisplay];
}
- (void)setNeedDisplaySubView{
    
    [dataAnaylsisView setNeedsDisplay];
}
@end

#define kOilNavControllerItemWidth 150.f

@interface CarDriveMannerAnalysisViewController ()

@end

@implementation CarDriveMannerAnalysisViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSArray*)viewControllersForNavItemController:(CarDataAnalysisBaseViewController*)controller{
    NSMutableArray *vcArray = [NSMutableArray array];
    UIViewController *vcCtl = [[CarDriveMannerDataViewController alloc]init];
    vcCtl.view.backgroundColor = [UIColor clearColor];
    //vcCtl.view.backgroundColor = [UIColor redColor];
    [vcArray addObject:vcCtl];
    SafeRelease(vcCtl);
    vcCtl = [[CarDriveMannerDataGraphViewController alloc]init];
    vcCtl.view.backgroundColor = [UIColor clearColor];
    [vcArray addObject:vcCtl];
    SafeRelease(vcCtl);
    return  vcArray;
}
-(NETopNavBar*)topNavBarForNavItemController:(CarDataAnalysisBaseViewController*)controller{
    
    NSMutableArray *btnArray = [NSMutableArray array];
    
    CGFloat currX = 0.f;
    
    UIButton *btn = [UIComUtil createButtonWithNormalBGImageName:nil withHightBGImageName:nil  withTitle:@"驾驶数据" withTag:0];
    btn.frame = CGRectMake(currX, 10.f,kOilNavControllerItemWidth, 30.f);
    [btnArray addObject:btn];
    currX = currX+kOilNavControllerItemWidth;
    btn = [UIComUtil createButtonWithNormalBGImageName:nil withHightBGImageName:nil withTitle:@"驾驶分析" withTag:0];
    btn.frame = CGRectMake(currX, 10.f,kOilNavControllerItemWidth, 30.f);
    [btnArray addObject:btn];
    
    
    /*
    CGFloat currX = 0.f;
    UIButton *btn = [UIComUtil createButtonWithNormalBGImageName:nil withHightBGImageName:nil  withTitle:@"" withTag:0];
    btn.frame = CGRectMake(currX, 10.f,150, 30.f);
    [btnArray addObject:btn];
    btn = [UIComUtil createButtonWithNormalBGImageName:nil withHightBGImageName:nil withTitle:@"驾驶分析" withTag:0];
    btn.frame = CGRectMake(160.f, 10.f,150, 30.f);
    [btnArray addObject:btn];
    */
    NETopNavBar *topNavBar = [[NETopNavBar alloc]initWithFrame:CGRectMake(0.f, 0.f, 300, 30)withBgImage:nil withBtnArray:btnArray selIndex:0];
    //topNavBar.delegate = self;
    return topNavBar;
}

@end
