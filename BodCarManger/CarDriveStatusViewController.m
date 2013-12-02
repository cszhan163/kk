//
//  CarMonitorViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-9-17.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarDriveStatusViewController.h"

#import "BSPreViewScrollView.h"
#import "CarDriveStatusView.h"

#import "CarDriveOilAnalaysisViewController.h"

#import "CarDriveMannerAnalysisViewController.h"

#import "CarMaintainanceView.h"


#import "CarDriveMannerDataViewController.h"

#import "XLCycleScrollView.h"


#define kLeftPendingX  10
#define kTopPendingY  8
#define kHeaderItemPendingY 8

#define kDriveStatusViewWidth  300
#define kDriveStatusViewHeight 259


//#define kCalendarWidth  (kDeviceScreenWidth-18.f)
//#define kCalendarHeight 250
#define kNumberCalViewTag 999


#define kDriveMaintainanceLeftPendingX 36.f

static NSString* kMonthTextArray[] = {
    @"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"
};

@interface CarMonitorViewController()<BSPreviewScrollViewDelegate,
        XLCycleScrollViewDelegate,
        XLCycleScrollViewDatasource>{

    UILabel *panelHeaderLabel;
    CarMaintainanceView *carMaintainanceView;
    DateStruct currDate;
#ifndef Infinite
    BSPreviewScrollView *scrollerView;
#else
    XLCycleScrollView *scrollerView;
#endif
    
}
@property(nonatomic,strong)NSMutableDictionary *mMaitiananceDict;
@end

@implementation CarMonitorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.mMaitiananceDict = [NSMutableDictionary dictionary];
        self.mDataDict = [NSMutableDictionary dictionary];
        //self.mHasDataDict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self checkDataChange];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
#if 1
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"car_bg.png");
    mainView.bgImage = bgImage;
#else
    mainView.mainFramView.backgroundColor = kAppUserBGWhiteColor;
#endif
    //mainView.alpha = 0.;
    [self setNavgationBarTitle:NSLocalizedString(@"驾驶行为", @""
                                                 )];
    [self setRightBtnHidden:YES];
    [self setHiddenLeftBtn:YES];
    
    
    CGFloat currY = kMBAppTopToolBarHeight+kTopPendingY;
    
    UIImageWithFileName(bgImage, @"drive_panel_header.png");
    
#if 0
    panelHeaderLabel= [[UILabel alloc]initWithFrame:CGRectZero];
    panelHeaderLabel.text = @"七月驾驶情况";
    panelHeaderLabel.textAlignment = NSTextAlignmentCenter;
    panelHeaderLabel.layer.contents = (id)bgImage.CGImage;
    panelHeaderLabel.backgroundColor = [UIColor clearColor];
    panelHeaderLabel.frame = CGRectMake(kLeftPendingX,currY,bgImage.size.width/kScale, bgImage.size.height/kScale);
    [self.view  addSubview:panelHeaderLabel];
    SafeRelease(panelHeaderLabel);
    currY = currY+bgImage.size.height/kScale;
#else
    
#endif
    
    
    //bgView.frame = viewRect;
    CGRect viewRect = CGRectMake(kLeftPendingX,currY,kDeviceScreenWidth-2*kLeftPendingX,kDriveStatusViewHeight);
    CGSize size = viewRect.size;
#ifndef Infinite
   //CGSizeMake(viewRect.size, bgImage.size.height/kScale);
    scrollerView = [[BSPreviewScrollView alloc]initWithFrameAndPageSize:CGRectMake(0.f, 0.f,size.width, size.height) pageSize:size];
    scrollerView.delegate = self;
    [scrollerView setBoundces:NO];
    scrollerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollerView];
    scrollerView.layer.cornerRadius = 5.f;
    scrollerView.frame =  viewRect;
    scrollerView.clipsToBounds = YES;
    
    [scrollerView setPageControlHidden:NO];
    
    StyledPageControl *pageControl = [scrollerView getPageControl];
#if 0
    UIImage *image  = nil;
    UIImageWithFileName(image ,@"page_normal.png");
    pageControl.thumbImage = image;
    UIImageWithFileName(image ,@"page_selected.png");
    pageControl.selectedThumbImage = image;
    pageControl.pageControlStyle = PageControlStyleThumb;
#else
    pageControl.coreNormalColor=  [UIColor whiteColor];
    pageControl.strokeNormalColor = [UIColor whiteColor];
    pageControl.coreSelectedColor = [UIColor grayColor];
    
#endif
    pageControl.diameter = 5.0;
    pageControl.strokeWidth = 2.f;
    
    CGRect rect = pageControl.frame;
    //[self.scrollViewPreview setPageControlFrame:CGRectMake(0.f,rect.size.height-80.f,kDeviceScreenWidth, 40.f)];
    pageControl.frame = CGRectOffset(rect, 0.f, -40.f+38-5);

    [scrollerView bringSubviewToFront:pageControl];
    [scrollerView scrollerRightTonextPageNum:1];
#else
    scrollerView = [[XLCycleScrollView alloc] initWithFrame:viewRect];
    scrollerView.delegate = self;
    scrollerView.datasource = self;
    scrollerView.pageControl.hidden = YES;
    [scrollerView setRightScroller:NO];
    [self.view addSubview:scrollerView];
    SafeRelease(scrollerView);
    currY = currY+scrollerView.frame.size.height;
#endif
    
    UIButton *oilAnalaysisBtn = [UIComUtil createButtonWithNormalBGImageName:@"drive_oil_btn.png" withHightBGImageName:@"drive_oil_btn.png" withTitle:@"" withTag:0];
    [scrollerView addSubview:oilAnalaysisBtn];
    CGSize btnsize= oilAnalaysisBtn.frame.size;
    oilAnalaysisBtn.frame = CGRectMake(30.f,size.height-10.f-btnsize.height,btnsize.width ,btnsize.height);
    [oilAnalaysisBtn addTarget:self action:@selector(didTouchButton:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *driveAnalysisBtn = [UIComUtil createButtonWithNormalBGImageName:@"drive_habit_btn.png" withHightBGImageName:@"drive_habit_btn.png" withTitle:@"" withTag:1];
    [scrollerView addSubview:driveAnalysisBtn];
    
    btnsize = driveAnalysisBtn.frame.size;
    driveAnalysisBtn.frame =  CGRectMake(300-30.f-btnsize.width+5,size.height-10.f-btnsize.height,btnsize.width ,btnsize.height);
    [driveAnalysisBtn addTarget:self action:@selector(didTouchButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //for 
    //[self addMaintainaceUI];
#if 1
    carMaintainanceView = [[CarMaintainanceView alloc]initWithFrame:CGRectMake(kDriveMaintainanceLeftPendingX,currY+8.f, kDeviceScreenWidth-2*kDriveMaintainanceLeftPendingX,80)];
    
    
    [carMaintainanceView setLeftProcessLen:84 rightLen:84];
    
    [self.view addSubview:carMaintainanceView];
    SafeRelease(carMaintainanceView);
#endif
    
    
    //[self setRightTextContent:NSLocalizedString(@"Done", @"")];
	// Do any additional setup after loading the view.
}
- (void)addMaintainaceUI{
    
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
-(UIView*)viewForItemAtIndex:(BSPreviewScrollView*)scrollView index:(int)index{
    
    UIView *maskView =[[UIView alloc]initWithFrame:CGRectMake(0.,0.f,kDriveStatusViewWidth, kDriveStatusViewHeight)];
    // maskView.frame =
    //[maskView addSubview:maskView];
    CarDriveStatusView *carDriveStatusView = [UIComUtil  instanceFromNibWithName:@"CarDriveStatusView"];
    [maskView addSubview:carDriveStatusView];
    [carDriveStatusView setTarget:self withAction:@selector(didTouchButton:)];
    //SafeRelease(carDriveStatusView);
    return maskView;
}
-(int)itemCount:(BSPreviewScrollView*)scrollView{
    return  3;
}
-(void)didScrollerView:(BSPreviewScrollView*)scrollView{
    int curIndex = scrollView.getPageControl.currentPage;
  
    if(curIndex>pageIndex){
        NSString *year = [NSString stringWithFormat:@"%d",self.mCurrDate.year];
        NSString *month = [NSString stringWithFormat:@"%d",self.mCurrDate.month];
        if(self.mCurrDate.month>12){
            year = [NSString stringWithFormat:@"%d",self.mCurrDate.year+1];
            month = @"1";
        }
        NSDictionary *day = [NSDictionary dictionaryWithObjectsAndKeys:
                              year,@"year",
                             month,@"month",nil];
        [super didTouchAfterMoth:day];
    }
    else if(curIndex<pageIndex){
        
        NSString *year = [NSString stringWithFormat:@"%d",self.mCurrDate.year];
        NSString *month = [NSString stringWithFormat:@"%d",self.mCurrDate.month];
        if(self.mCurrDate.month>12){
            year = [NSString stringWithFormat:@"%d",self.mCurrDate.year-1];
            month = @"12";
        }
        NSDictionary *day = [NSDictionary dictionaryWithObjectsAndKeys:
                             year,@"year",
                             month,@"month",nil];
        [super didTouchAfterMoth:day];
        
    }
    pageIndex = curIndex;
    
}

#pragma mark -
#pragma mark -- Data Source Methods
- (NSInteger)numberOfPages{
    return 3;
}
//- (UIView *)pageAtIndex:(NSInteger)index{
//
//}
- (void)checkNetData{
    
    
}
- (UIView *)pageAtIndex:(NSInteger)index withView:(XLCycleScrollView*)senderView{
    
//    if(senderView.nolimitIndex == 0){
//        isTodayMonth = YES;
//    }
//    else{
//        isTodayMonth = NO;
//    }
    int month = self.mTodayDate.month +senderView.nolimitIndex+index;
    int year = self.mTodayDate.year;
    if(month>12){
        int num = month/12;
        year = self.mTodayDate.year+num;
        month = month%12;
    }
    if(month<=0){
        int num = -1+month/12;
        year = self.mTodayDate.year+num;
        month = 12+month%12;
    }
  
    int width = kDriveStatusViewWidth;
    int height = kDriveStatusViewHeight;
    CarDriveStatusView *carDriveStatusView = [UIComUtil  instanceFromNibWithName:@"CarDriveStatusView"];
    //[maskView addSubview:carDriveStatusView];
    [carDriveStatusView setDateKey:[NSString stringWithFormat:kDateFormart,year,month]];
    carDriveStatusView.frame = CGRectMake(0.f, 0.f, width,height);
    //for(id item in carDriveStatusView.subviews)
    {
        [carDriveStatusView  setTarget:self withAction:@selector(didtouchMonthChangeBtn:)];
    }
    return carDriveStatusView;
}
- (void)didEndScrollerView:(XLCycleScrollView*)senderView{
    
    if(currIndex == senderView.nolimitIndex){
        
    }
    else{
        int month = self.mTodayDate.month +senderView.nolimitIndex;
        int year = self.mTodayDate.year;
        if(month>12){
            int num = month/12;
            year = self.mTodayDate.year+num;
            month = month%12;
        }
        if(month<=0){
            int num = -1+month/12;
            year = self.mTodayDate.year+num;
            month = 12+month%12;
        }
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSString stringWithFormat:@"%d",month],@"month",
                              [NSString stringWithFormat:@"%d",year],@"year",nil];
        if(currIndex >senderView.nolimitIndex){
            [self didTouchPreMoth:dict];
            
        }
        else if (currIndex <senderView.nolimitIndex){
            [self didTouchAfterMoth:dict];
        }
        //NSLog(@"%@",[dict description]);
        
        currIndex = senderView.nolimitIndex;
        if(self.mTodayDate.month==self.mCurrDate.month && self.mTodayDate.year==self.mCurrDate.year){
            [senderView setRightScroller:NO];
        }
        else{
            [senderView setRightScroller:YES];
        }
    }
    
}

#pragma mark -
#pragma mark View Delegate
- (IBAction)didtouchMonthChangeBtn:(id)sender{
    if([sender tag] == 10)
        [scrollerView scrollerToPrePage];
    
    if([sender tag] == 11)
        [scrollerView scrollerToNextPage];
}


- (void)didTouchButton:(id)sender{

    switch ([sender tag]) {
        case 0:
            {
                CarDriveOilAnalaysisViewController *carDriveOilAnalaysisVc = [[CarDriveOilAnalaysisViewController
                                                                               alloc]init];
                carDriveOilAnalaysisVc.isNeedInitDateMonth = NO;
                carDriveOilAnalaysisVc.mCurrDate = self.mCurrDate;
#if 0
                [self.navigationController pushViewController:carDriveOilAnalaysisVc animated:YES];
                
#else
                [ZCSNotficationMgr postMSG:kPushNewViewController obj:carDriveOilAnalaysisVc];
#endif          
                
                SafeRelease(carDriveOilAnalaysisVc);
            }
            break;
        case 1:
        {
#if 1
           CarDriveMannerAnalysisViewController *carDriveMannerAnalysisVc =
           [[CarDriveMannerAnalysisViewController
              alloc]init];
            carDriveMannerAnalysisVc.isNeedInitDateMonth = NO;
            
            carDriveMannerAnalysisVc.mCurrDate = self.mCurrDate;
#else
            CarDriveMannerDataViewController *carDriveMannerAnalysisVc = [[CarDriveMannerDataViewController alloc]init];
#endif
#if 0
            [self.navigationController pushViewController:carDriveMannerAnalysisVc animated:YES];
#else
            [ZCSNotficationMgr postMSG:kPushNewViewController obj:carDriveMannerAnalysisVc]; 
#endif
            SafeRelease(carDriveMannerAnalysisVc);
        
        }
        default:
            break;
    }

}
#pragma mark -
#pragma mark net work
- (void)refulshNetData{
    
   
    NSString *userId = [AppSetting getLoginUserId];
    NSString *cardId = nil;
    if(userId){
        cardId = [AppSetting getUserCarId:userId];
    }
    CarServiceNetDataMgr *cardShopMgr = [CarServiceNetDataMgr getSingleTone];
    kNetStartShow(@"数据加载...", self.view);
    NSString *month = [NSString stringWithFormat:@"%d",self.mCurrDate.month];
    NSString *year = [NSString stringWithFormat:@"%d",self.mCurrDate.year];
    self.request = [cardShopMgr  getDriveDataByCarId:cardId withMonth:month withYear:year];
    [cardShopMgr getCarMaintainanceData:cardId];
}
-(void)didNetDataOK:(NSNotification*)ntf
{
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];
    //NSString *resKey = [respRequest resourceKey];
    if(self.request ==respRequest && [resKey isEqualToString:kResDriveDataMoth])
    {
        NSDictionary *netData = data;//[data objectForKey:@"data"];
        
        
        [self  performSelectorOnMainThread:@selector(updateUIData:) withObject:netData waitUntilDone:NO ];
        [self.mDataDict setObject:netData forKey:self.mMothDateKey];
        //}
        kNetEnd(self.view);
        
    }
    if([resKey isEqualToString:kResDriveMaintainData])
    {
        [self performSelectorOnMainThread:@selector(updateUIMainUIData:) withObject:data waitUntilDone:NO];
    }
}
-(void)didNetDataFailed:(NSNotification*)ntf
{
    //kNetEnd(@"", 2.f);
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];
    if(self.request ==respRequest && [resKey isEqualToString:kResDriveDataMoth])
    {
        kNetEnd(self.view);
    }
    if(self.request ==respRequest && [resKey isEqualToString:@"addreply"])
    {
        //kNetEnd(self.view);
    }
}
-(void)didRequestFailed:(NSNotification*)ntf
{
    //[self stopShowLoadingView];
    kNetEnd(self.view);
}
- (void)updateUIData:(NSDictionary*)netData{
   
    NSMutableDictionary *newNetData = [NSMutableDictionary dictionaryWithDictionary:netData];
    for(id key in netData){
        if([[netData objectForKey:key] isKindOfClass:[NSNull class]]){
            
            [newNetData setValue:@"" forKey:key];
        }
    }
    netData = newNetData;

    CarDriveStatusView *carDriveStatusView = nil;
#if 0
     NSArray *pageArray ＝ nil;
    pageArray= scrollerView.getScrollerPageViews;
    CarDriveStatusView *carDriveStatusView = [[[pageArray objectAtIndex:pageIndex]subviews]objectAtIndex:0];
#else
    
    carDriveStatusView = scrollerView.getCurrentPageView;
    NSLog(@"%@",[carDriveStatusView getDateKey]);
    if(![[carDriveStatusView getDateKey]isEqualToString:self.mMothDateKey]){
        return;
    }
#endif
    int oiltest = [[netData objectForKey:@"economicScore"]intValue];
    if(oiltest>=10) oiltest = 10;
    int drivetest = [[netData objectForKey:@"safeScore"]intValue];
    if(drivetest>=10) drivetest = 10;
    if(oiltest <= 0)
        oiltest = 1;
    NSString *fileName = [NSString stringWithFormat:@"dashboard%d.png",oiltest];
    UIImageWithFileName(UIImage *bgImage, fileName);
    carDriveStatusView.mOilCostAnalaysisImageView.image = bgImage;
    fileName = [NSString stringWithFormat:@"dashboard%d.png",drivetest];
    UIImageWithFileName(bgImage, fileName);
    carDriveStatusView.mDriveAnalaysisImageView.image = bgImage;
    
    
    
 
    float totalOil = [[netData objectForKey:@"toatalFuel"]floatValue];
    int day = [[netData objectForKey:@"days" ]intValue];
    float segment = [[netData objectForKey:@"segments"]floatValue];
    float totalMile = [[netData objectForKey:@"totalMilage"]floatValue];
    float avgOil = 0.f;
    if(totalMile>0.f){
        avgOil = totalOil/totalMile;
    }
    carDriveStatusView.mRunOilCostLabel.text = [NSString stringWithFormat:@"%0.2lf",avgOil*100];
    carDriveStatusView.mRunMoneyCostLabel.text = [NSString stringWithFormat:@"%0.2lf",totalOil];
    carDriveStatusView.mRunDaysLabel.text =[NSString stringWithFormat:@"%d",day];
    carDriveStatusView.mRunStepLabel.text = [NSString stringWithFormat:@"%0.lf",segment];
    carDriveStatusView.mRunDistanceLabel.text = [NSString stringWithFormat:@"%0.1lf",totalMile];
    int monthInex = self.mCurrDate.month-1;
    carDriveStatusView.mHeadMonthLabel.text = [NSString stringWithFormat:@"%@驾驶情况",kMonthTextArray[monthInex]];
}
- (void)updateUIMainUIData:(NSDictionary*)data{
    
    //for 84*len;
    //milageSpan
    int realDay = 0;
    int maxDay = 1;
    CGFloat realDistance = 0.f;
    CGFloat maxDistance = 100.f;
    if([[data objectForKey:@"days"] isKindOfClass:[NSNull class]]){
    }
    else{
        realDay = [[data objectForKey:@"days"] intValue];
    }
    if([[data objectForKey:@"timeSpan"] isKindOfClass:[NSNull class]]){
    
    }
    else{
        maxDay = [[data objectForKey:@"timeSpan"]intValue];
    }
    if([[data objectForKey:@"milage"] isKindOfClass:[NSNull class]]){
        
    }
    else{
        realDistance = [[data objectForKey:@"milage"]floatValue];
    }
    if([[data objectForKey:@"milageSpan"] isKindOfClass:[NSNull class]]){
        
    }
    else{
        maxDistance = [[data objectForKey:@"milageSpan"]floatValue];
    }
    CGFloat day =  realDay/(maxDay*30.f) *84.f;
    CGFloat distance = realDistance/maxDistance*84.f;
    if(realDay>=maxDay-10||realDistance>=maxDistance-2000)
    {
        UIImageWithFileName(UIImage *bgImage, @"matain_need.png");
        [carMaintainanceView setCenterImageView:bgImage];
    }
    [carMaintainanceView setLeftProcessLen:day rightLen:distance];
    [carMaintainanceView setLeftProcessDay:realDay rightDistance:realDistance];
}
- (void)clearLogoutData:(NSNotification*)ntf{
    [self.mDataDict removeAllObjects];
    //[self.mHasDataDict removeAllObjects];
    
}
@end
