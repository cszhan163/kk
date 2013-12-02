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


@interface CarDriveOilAnalaysisViewController ()<UIBaseViewControllerDelegate>

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
    //self.delegate = self;
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
#if 1
    CarDriveOilDataViewController *dataVc = [[CarDriveOilDataViewController alloc]init];
    dataVc.mCurrDate = self.mCurrDate;
    dataVc.view.backgroundColor = [UIColor clearColor];
    //[vcCtl setRootViewController:controller];
    //dataVc.view.backgroundColor = [UIColor redColor];
    [vcArray addObject:dataVc];
    SafeRelease(dataVc);
#endif
    CarDriveOilDataAnalaysisViewController *analysisVc = [[CarDriveOilDataAnalaysisViewController  alloc]init];
    analysisVc.view.backgroundColor = [UIColor clearColor];
    //[vcCtl setRootViewController:controller];
    [vcArray addObject:analysisVc];
    SafeRelease(analysisVc);
    //return nil;
    return  vcArray;
}
#define kOilNavControllerItemWidth 150.f
-(NETopNavBar*)topNavBarForNavItemController:(CarDataAnalysisBaseViewController*)controller{

    NSMutableArray *btnArray = [NSMutableArray array];
    CGFloat currX = 0.f;
    UIButton *btn = [UIComUtil createButtonWithNormalBGImageName:@"nav_data_normal.png" withSelectedBGImageName:@"nav_data_selected.png"  withTitle:@"经济驾驶数据" withTag:0];
    btn.frame = CGRectMake(currX, 10.f,kOilNavControllerItemWidth, btn.frame.size.height);
    
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn setTitleColor:HexRGB(153, 153, 153) forState:UIControlStateNormal];
    [btn setTitleColor:HexRGB(231, 234, 236) forState:UIControlStateSelected];
    
    [btnArray addObject:btn];
    
    
    currX = currX+kOilNavControllerItemWidth;
    btn = [UIComUtil createButtonWithNormalBGImageName:@"nav_analysis_normal.png" withSelectedBGImageName:@"nav_analysis_selected.png" withTitle:@"经济驾驶分析" withTag:1];
    btn.frame = CGRectMake(currX, 10.f,kOilNavControllerItemWidth, btn.frame.size.height);
    
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn setTitleColor:HexRGB(153, 153, 153) forState:UIControlStateNormal];
    [btn setTitleColor:HexRGB(231, 234, 236) forState:UIControlStateSelected];
    
    [btnArray addObject:btn];
    
    NETopNavBar *topNavBar = [[NETopNavBar alloc]initWithFrame:CGRectMake(0.f,0.f, 300, btn.frame.size.height)withBgImage:nil withBtnArray:btnArray selIndex:0];
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
#pragma mark -
#pragma mark network

- (void)loadAnalaysisData{
    
    CarServiceNetDataMgr *cardShopMgr = [CarServiceNetDataMgr getSingleTone];
    
    kNetStartShow(@"数据加载...", self.view);
    NSString *month = [NSString stringWithFormat:@"%d",self.mCurrDate.month];
    NSString *year = [NSString stringWithFormat:@"%d",self.mCurrDate.year];
    self.request = [cardShopMgr  getDriveOilAnalysisDataByCarId:@"SHD05728" withMoth:month withYear:year];
    
}

-(void)didNetDataOK:(NSNotification*)ntf
{
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];
    //NSString *resKey = [respRequest resourceKey];
    if(self.request ==respRequest && [resKey isEqualToString:kResDriveOilAnalysis])
    {
        self.data = data;
        //self.dataArray = [data objectForKey:@"economicData"];
        [self  performSelectorOnMainThread:@selector(updateUIData:) withObject:data waitUntilDone:NO ];
        //[mDataDict setObject:netData forKey:mMothDateKey];
        //}
        kNetEnd(self.view);
        
    }
    
}
- (void)updateUIData:(NSDictionary*)data{
    
    NSArray *economicData = [data objectForKey:@"economicData"];
    economicData = [economicData sortedArrayUsingComparator:^(id param1,id param2){
        
        id arg1 = [param1 objectForKey:@"day"];
        id arg2 = [param2 objectForKey:@"day"];
        if([arg1 intValue]>[arg2 intValue]){
            return NSOrderedDescending;
        }
        else if([arg1 intValue]<[arg1 intValue]){
            return NSOrderedAscending;
        }
        else{
            return NSOrderedSame;
        }
        
    }];
    //[data ]
    
    NSMutableDictionary *newData = [NSMutableDictionary dictionaryWithDictionary:data];
    [newData setValue:economicData forKey:@"economicData"];
    CarDriveOilDataViewController *oilDataVc = [navItemCtrl.navControllersArr objectAtIndex:0];
    [oilDataVc updateUIData:newData];
    CarDriveOilDataAnalaysisViewController *analysisVc = [navItemCtrl.navControllersArr objectAtIndex:1];
    [analysisVc updateUIData:newData];
}
@end
