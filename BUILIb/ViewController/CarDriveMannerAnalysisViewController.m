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
//#import "SubNavItemBaseViewController.h"
#import "CarDriveMannerDataViewController.h"
#import "CarDriveOilDataViewController.h"
#import "CarDriveMannerDataGraphViewController.h"

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
    [self setNavgationBarTitle:[NSString stringWithFormat:@"%d年%d月",self.mCurrDate.year,self.mCurrDate.month]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSArray*)viewControllersForNavItemController:(CarDataAnalysisBaseViewController*)controller{
    NSMutableArray *vcArray = [NSMutableArray array];
    CarDriveMannerDataViewController *vcCtl = [[CarDriveMannerDataViewController alloc]init];
    vcCtl.isNeedInitDateMonth = NO;
    vcCtl.mCurrDate = self.mCurrDate;
    vcCtl.view.backgroundColor = [UIColor clearColor];
    //vcCtl.view.backgroundColor = [UIColor redColor];
    [vcArray addObject:vcCtl];
    SafeRelease(vcCtl);
    CarDriveMannerDataGraphViewController *vcGraphCtl = [[CarDriveMannerDataGraphViewController alloc]init];
    vcGraphCtl.view.backgroundColor = [UIColor clearColor];
    vcGraphCtl.isNeedInitDateMonth = NO;
    vcGraphCtl.mCurrDate = self.mCurrDate;
    [vcArray addObject:vcGraphCtl];
    SafeRelease(vcGraphCtl);
    return  vcArray;
}
-(NETopNavBar*)topNavBarForNavItemController:(CarDataAnalysisBaseViewController*)controller{
    
    NSMutableArray *btnArray = [NSMutableArray array];
    CGFloat currX = 0.f;
    UIButton *btn = [UIComUtil createButtonWithNormalBGImageName:@"nav_data_normal.png" withSelectedBGImageName:@"nav_data_selected.png"  withTitle:@"安全驾驶数据" withTag:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn setTitleColor:HexRGB(153, 153, 153) forState:UIControlStateNormal];
    [btn setTitleColor:HexRGB(231, 234, 236) forState:UIControlStateSelected];
    btn.frame = CGRectMake(currX, 10.f,kOilNavControllerItemWidth, btn.frame.size.height);
    [btnArray addObject:btn];
    currX = currX+kOilNavControllerItemWidth;
    btn = [UIComUtil createButtonWithNormalBGImageName:@"nav_analysis_normal.png" withSelectedBGImageName:@"nav_analysis_selected.png" withTitle:@"安全驾驶分析" withTag:1];
    
    btn.frame = CGRectMake(currX, 10.f,kOilNavControllerItemWidth, btn.frame.size.height);
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn setTitleColor:HexRGB(153, 153, 153) forState:UIControlStateNormal];
    [btn setTitleColor:HexRGB(231, 234, 236) forState:UIControlStateSelected];
    
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
    NETopNavBar *topNavBar = [[NETopNavBar alloc]initWithFrame:CGRectMake(0.f, 0.f, 300, btn.frame.size.height)withBgImage:nil withBtnArray:btnArray selIndex:0];
    //topNavBar.delegate = self;
    return topNavBar;
}
#pragma mark -
#pragma mark network

- (void)loadAnalaysisData{
    
    CarServiceNetDataMgr *cardShopMgr = [CarServiceNetDataMgr getSingleTone];
    
    kNetStartShow(@"数据加载...", self.view);
    NSString *month = [NSString stringWithFormat:@"%02d",self.mCurrDate.month];
    NSString *year = [NSString stringWithFormat:@"%d",self.mCurrDate.year];
    NSString *carId = [AppSetting getUserCarId:[AppSetting getLoginUserId]];
    self.request = [cardShopMgr  getDriveActionAnalysisDataByCarId:carId withMoth:month withYear:year];
    
}

-(void)didNetDataOK:(NSNotification*)ntf
{
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];
    //NSString *resKey = [respRequest resourceKey];
    if(self.request ==respRequest && [resKey isEqualToString:kResDriveActionAnalysis])
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
    
    NSArray *economicData = [data objectForKey:@"safeData"];
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
    [newData setValue:economicData forKey:@"safeData"];
    CarDriveMannerDataViewController *oilDataVc = [navItemCtrl.navControllersArr objectAtIndex:0];
    [oilDataVc updateUIData:newData];
    CarDriveMannerDataGraphViewController *analysisVc = [navItemCtrl.navControllersArr objectAtIndex:1];
    [analysisVc updateUIData:newData];
}
@end
