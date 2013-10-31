//
//  CarDriveOilAnalaysisViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-10-3.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarDriveOilAnalaysisViewController.h"
#import "DriveActionAnalysisView.h"
#import "SubNavItemBaseViewController.h"
#import "CarDriveOilDataAnalaysisViewController.h"
#import "CarDriveOilDataViewController.h"


@interface CarDriveOilAnalaysisViewController ()

@end

@implementation CarDriveOilAnalaysisViewController

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
    self.delegate = self;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark viewController datasource
-(NSArray*)viewControllersForNavItemController:(CarDataAnalysisBaseViewController*)controller{
    NSMutableArray *vcArray = [NSMutableArray array];
    CarDriveOilDataViewController *dataVc = [[CarDriveOilDataViewController alloc]init];
    dataVc.mCurrDate = self.mCurrDate;
    dataVc.view.backgroundColor = [UIColor clearColor];
    //[vcCtl setRootViewController:controller];
    //vcCtl.view.backgroundColor = [UIColor redColor];
    [vcArray addObject:dataVc];
    SafeRelease(dataVc);
    CarDriveOilDataAnalaysisViewController *analysisVc = [[CarDriveOilDataAnalaysisViewController  alloc]init];
    analysisVc.view.backgroundColor = [UIColor clearColor];
    //[vcCtl setRootViewController:controller];
    [vcArray addObject:analysisVc];
    SafeRelease(analysisVc);
    return  vcArray;
}
#define kOilNavControllerItemWidth 150.f
-(NETopNavBar*)topNavBarForNavItemController:(CarDataAnalysisBaseViewController*)controller{

    NSMutableArray *btnArray = [NSMutableArray array];
    CGFloat currX = 0.f;
    UIButton *btn = [UIComUtil createButtonWithNormalBGImageName:@"oil_data_normal.png" withSelectedBGImageName:@"oil_data_selected.png"  withTitle:@"" withTag:0];
    btn.frame = CGRectMake(currX, 10.f,kOilNavControllerItemWidth, 30.f);
    [btnArray addObject:btn];
    currX = currX+kOilNavControllerItemWidth;
    btn = [UIComUtil createButtonWithNormalBGImageName:@"oil_analysis_normal.png" withSelectedBGImageName:@"oil_analysis_selected.png" withTitle:@"" withTag:0];
    btn.frame = CGRectMake(currX, 10.f,kOilNavControllerItemWidth, 30.f);
    [btnArray addObject:btn];
    
    NETopNavBar *topNavBar = [[NETopNavBar alloc]initWithFrame:CGRectMake(0.f,0.f, 300, 30)withBgImage:nil withBtnArray:btnArray selIndex:0];
    //topNavBar.delegate = self;
    //[self.view addSubview:topNavBar];
    //[self.view bringSubviewToFront:topNavBar];
    //SafeRelease(topNavBar);
    return topNavBar;
}
- (void)setNeedDisplaySubView{
    
}
#pragma mark -
-(void)didSelectorTopNavigationBarItem:(id)sender{
    switch ([sender tag]) {
        case  0:
            //[self.navigationController popViewControllerAnimated:YES];// animated:<#(BOOL)animated#>
			break;
        case 2:
        case 1:{
            NSLog(@"%d",navItemCtrl.getTabNavBar.getTabNavSelectIndex);
            if(navItemCtrl.getTabNavBar.getTabNavSelectIndex == 0){
                if([navItemCtrl.currentViewController respondsToSelector:@selector(didSelectorTopNavItem:)]){
                    
                    //[navItemCtrl.currentViewController didSelectorTopNavItem:sender withButton:self.right];
                    
                }
            }
        }
    }
}

@end
