//
//  CarRouterMapViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-9-17.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarRouterDetailViewController.h"
#import "MapView.h"
#import "CarDetailPenalView.h"
#import "WGS2Mars.h"
#import "DBManage.h"
#import "CarRouterDateViewController.h"

@interface CarRouterDetailViewController (){
    MapView     *mMapView;
    Place       *mStartPoint;
    Place       *mEndPoint;
    CarDetailPenalView * carDetailPenalView;
    DateStruct  mDateStruct;
    
    CLLocationCoordinate2D mStartCoordinate2d;
    CLLocationCoordinate2D mEndCoordinate2d;
    CGFloat                mEndSpeed;
   
    
}
@property(nonatomic,strong)NSTimer *realDataTimer;
@property(nonatomic,strong)NSMutableArray *gprsDataArray;
@end

@implementation CarRouterDetailViewController
@synthesize isLatest;
@synthesize mData;

#if __has_feature(objc_arc)
#else
- (void)dealloc{
    self.realDataTimer = nil;
    self.gprsDataArray = nil;
    [super dealloc];
}
#endif

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.gprsDataArray = [NSMutableArray array];
        self.mEndName = @"未知";
        self.mStartName = @"未知";
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    if(self.isRunning ){
//#if TEST_RUNNING
//         [self updateUIRealTimeCheck:nil];
//#else
//        
//        [ZCSNotficationMgr postMSG:kCheckCardRecentRun obj:nil];
//#endif
    }
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[DBManage getSingletone]setDelegate:nil];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
- (void)releseTimer{
    [self.realDataTimer invalidate];
    self.realDataTimer  = nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"car_bg.png");
    
    mainView.bgImage = bgImage;
    
    UIImageWithFileName(bgImage, @"share.png");
     //[self setNavgationBarRightBtnImage:bgImage forStatus:UIControlStateNormal];
    
    //ma
    
    // startPosition, endPosition;
#if kLocationPhone
#else
    NSString *startLocation = [mData objectForKey:@"startPosition"];
    if(startLocation == nil||[startLocation isKindOfClass:[NSNull class]]||[startLocation isEqualToString:@""]){
        self.mStartName = @"未知";
    }
    else{
        self.mStartName = startLocation;
    }
    NSString *endLocation = [mData objectForKey:@"endPosition"];
    if(endLocation == nil||[endLocation isKindOfClass:[NSNull class]]||[endLocation isEqualToString:@""]){
        self.mEndName = @"未知";
    }
    else{
        self.mEndName = endLocation;
    }
#endif
    

//    UIButton *btn = [UIComUtil createButtonWithNormalBGImage:bgImage withHightBGImage:bgImage withTitle:@"" withTag:2];
//    [btn addTarget:self action:@selector(didSelectorTopNavItem:) forControlEvents:UIControlEventTouchUpInside];
//    btn.frame = CGRectMake(0,0.f,bgImage.size.width/kScale,bgImage.size.height/kScale);
//    btn.center = CGPointMake(mainView.topBarView.center.x+65,mainView.topBarView.center.y);
#if 0
    [mainView.topBarView addSubview:btn];
#else
    
  
#endif
    mMapView = [[MapView alloc] initWithFrame:
               CGRectMake(0, 44, self.view.frame.size.width,460-44)];
    
	[self.view addSubview:mMapView];
    SafeRelease(mMapView);
    
    
    carDetailPenalView = [UIComUtil instanceFromNibWithName:@"CarDetailPenalView"];
    [self.view addSubview:carDetailPenalView];
    CGFloat offsetY = 0.f;
#if kMapHasTab
    offsetY = kMBAppBottomToolBarHeght-1;
#endif
    carDetailPenalView.frame = CGRectMake(0.f,kDeviceScreenHeight-kMBAppStatusBar-carDetailPenalView.frame.size.height-offsetY, carDetailPenalView.frame.size.width, carDetailPenalView.frame.size.height);
    
    [UIView animateWithDuration:0.5 animations:^()
     {
         
        }
     ];
    
    [self initMapPointData:mData];
   
   // [mMapView showRouteFrom:mStartPoint to:mEndPoint];
#if TEST_RUNNING
    if(_isFromDateView)
        return;
    [self  performSelector:@selector(updateUIRealTimeCheck:) withObject:nil  afterDelay:0.f];
#else
    if(_isFromDateView)
    {
        kNetStartShow(@"数据加载...", self.view);
        [ZCSNotficationMgr postMSG:kCheckCardRecentRun obj:nil];
        UIImageWithFileName(bgImage, @"calendar.png");
        [self.leftBtn setBackgroundImage:bgImage forState:UIControlStateNormal];
        [self.leftBtn setBackgroundImage:bgImage forState:UIControlStateSelected];
        //self.leftBtn = btn;
    }
    else{
        
        //[self performSelectorInBackground:@selector(loadRouterHistoryData) withObject:nil];
        [self loadRouterHistoryData];
    }
#endif
    //[mainView.topBarView ];
	// Do any additional setup after loading the view.
    [self setRightBtnHidden:YES];
}

- (void)loadRouterHistoryData{

    CarServiceNetDataMgr *cardShopMgr = [CarServiceNetDataMgr getSingleTone];
    kNetStartShow(@"数据加载...", self.view);
    NSString *tipId = [self.mData objectForKey:@"tripId"];
    NSString *startTime = [self.mData objectForKey:@"startTime"];
    NSString *carId = nil;
    carId = [AppSetting getUserCarId:nil];
    self.request = [cardShopMgr  getRouterHistoryData:carId withRouterId:tipId withStartTime:startTime];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initMapPointData:(NSDictionary*)data{
    
    /*
     "driveflg": "1",
     "starttime": "17:54",
     "distance": "12",
     "time": "43",
     "oil": "25",
     "startadr": "张江地铁",
     "endadr": "人民广场",
     "startadr2": "121.607931, 31.211412",
     "endadr2": "121.48117, 31.236416",
     
     "rotate": "86",
     "speed": "34",
     "water temp": "64",
     "oiltest": "8",
     "drivetest": "7"
        */
    /*
    NSString *start = @"";
    [data objectForKey:@"startadr"];
    */
    mStartPoint = [[Place alloc] init] ;
	mStartPoint.name = @"";
	mStartPoint.description = @"";
    NSString *latLogStr = [data objectForKey:@"startadr2"];
    NSArray *latLogArr  = [latLogStr componentsSeparatedByString:@","];
    mStartPoint.latitude = [latLogArr[1]floatValue]/kGPSMaxScale;
	mStartPoint.longitude = [latLogArr[0]floatValue]/kGPSMaxScale;
	
	mEndPoint = [[Place alloc] init] ;
	mEndPoint.name = [data objectForKey:@"endadr"];
	mEndPoint.description = @"";
    latLogStr = [data objectForKey:@"endadr2"];
    latLogArr  = [latLogStr componentsSeparatedByString:@","];
    mEndPoint.latitude = [latLogArr[1]floatValue]/kGPSMaxScale;
	mEndPoint.longitude = [latLogArr[0]floatValue]/kGPSMaxScale;
    
    /*
     "rotate": "86",
     "speed": "34",
     "water temp": "64",
     "oiltest": "8",
     "drivetest": "7"
     */
    [self setPanelUIByData:data];
    
    SafeRelease(mStartPoint);
    SafeRelease(mEndPoint);
}
- (void)setPanelUIByData:(NSDictionary*)data{

    NSString *distance = [data objectForKey:@"tripMileage"];
    if(distance == nil){
        distance = @"00";
    }
    NSString *speed = [data objectForKey:@"speed"];
    NSString *rotate = [data objectForKey:@"fuelWear"];
    if(rotate == nil){
        rotate = @"00";
    }
    NSString *tempreture = [data objectForKey:@"tempreture"];
    
    carDetailPenalView.mRunDistanceLabel.text = [NSString stringWithFormat:@"行驶距离: %0.2lfkm",[distance floatValue]];
    carDetailPenalView.mRunSpeedLabel.text = [NSString stringWithFormat:@"行驶速度-  %@km/h",speed];
    carDetailPenalView.mRotateSpeedLabel.text= [NSString stringWithFormat:@"油耗: %0.2lfL",[rotate floatValue]];
    carDetailPenalView.mRunTemperatureLabel.text = [NSString stringWithFormat:@"水温:-  %@度",tempreture];
    
    //    NSString *timeStr = [data objectForKey:@"starttime"];
    //
    //    NSArray *timeArr  = [timeStr componentsSeparatedByString:@" "];
    //    if(!isLatest && timeArr[0])
    //        [self setNavgationBarTitle:timeArr[0]];
    //	NSArray *dateArr = [timeArr[0] componentsSeparatedByString:@"/"];
    //    mDateStruct.year = [dateArr[0]intValue];
    //    mDateStruct.month = [dateArr[1]intValue];
    //    mDateStruct.day =  [dateArr[2]intValue];
    
    int oiltest = [[data objectForKey:@"economicScore"]intValue];
    if(oiltest>=10) oiltest = 10;
    int drivetest = [[data objectForKey:@"safeScore"]intValue];
    if(drivetest>=10) drivetest = 10;
    
    NSString *fileName = [NSString stringWithFormat:@"dashboard%d.png",oiltest];
    UIImageWithFileName(UIImage *bgImage, fileName);
    carDetailPenalView.mOilCostAnalaysisImageView.image = bgImage;
    fileName = [NSString stringWithFormat:@"dashboard%d.png",drivetest];
    UIImageWithFileName(bgImage, fileName);
    carDetailPenalView.mDriveAnalaysisImageView.image = bgImage;
}
#pragma mark -
#pragma mark navigation bar action
-(void)didSelectorTopNavItem:(id)navObj{
    switch ([navObj tag]) {
        case  0:
            [self releseTimer];
            [self.navigationController popViewControllerAnimated:YES];// animated:<#(BOOL)animated#>
            
			break;
        case 2:
        case 1:{
            //[ZCSNotficationMgr postMSG:kPopAllViewController obj:nil];
            
            UIImage *image = [UIComUtil getCurrentViewShortCut:[[[UIApplication sharedApplication]delegate]window]];
            
            //[NSDictionary *]
            
            [ZCSNotficationMgr postMSG:kStartShowSharedViewMSG obj:image];
            /*
            CarRouterDateViewController *carRouterDateChooseVc = [[CarRouterDateViewController alloc]init];
            carRouterDateChooseVc.mCurrDate = mDateStruct;
            [self.navigationController pushViewController:carRouterDateChooseVc animated:YES];
            Safe_Release(carRouterDateChooseVc);
             */
           
            }
            break;
            
        default:
            break;
    }
}
-(void)didNetDataOK:(NSNotification*)ntf
{
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];
    //NSString *resKey = [respRequest resourceKey];
    if(self.request ==respRequest && [resKey isEqualToString:kResRouterHistory])
    {
        kNetEnd(self.view);
        NSDictionary *netData = data;//[data objectForKey:@"data"];
        self.gprsDataArray = [netData objectForKey:@"gps"];
        //[self getPlaceNameByPosition:self.gprsDataArray];
        
        [self  performSelectorOnMainThread:@selector(updateUIData:) withObject:netData waitUntilDone:NO ];
        //[mDataDict setObject:netData forKey:mMothDateKey];
        //}

        
        
    }
    if(self.request ==respRequest && [resKey isEqualToString:kResRouterNow])
    {
        kNetEnd(self.view);
        NSDictionary *netData = data;//[data objectForKey:@"data"];
        //[self.gprsDataArray insertObject:[netData objectForKey:@"gps"] atIndex:0];
        //[self getPlaceNameByPosition:self.gprsDataArray];

        [self  performSelectorOnMainThread:@selector(updateUIRealTimeData:) withObject:netData waitUntilDone:NO ];
        //[mDataDict setObject:netData forKey:mMothDateKey];
        //}
        //kNetEnd(self.view);
        
    }
    if([resKey isEqualToString:kResRouterLatest])
    {
        //BOOL isRunning = NO;
        
        if([[data objectForKey:@"endTime"] isEqualToString:@"0"])
        {//the card is Running
            self.isRunning = YES;
            
        }
        else{
            self.isRunning = NO;
        }
        //self.isRunning = YES;
        if([[data objectForKey:@"tripId"]intValue] !=0){
            self.mData = data;
            [self performSelectorOnMainThread:@selector(updateUIRealTimeCheck:) withObject:nil waitUntilDone:NO];
        }
        else{
            kNetEnd(self.view);
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
       
    }
    
}
-(void)didNetDataFailed:(NSNotification*)ntf
{
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];
    if(self.request ==respRequest && [resKey isEqualToString:kResRouterHistory])
    {
        kNetEnd(self.view);
        kNetEndWithErrorAutoDismiss(@"加载数据失败", 2.f);
        //[self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    
    //NE_LOG(@"warning not implemetation net respond");
}



- (void)updateUIData:(NSDictionary*)data{

    NSMutableArray *gpsScaleArray = [NSMutableArray array];
    int index = 0;
    int totalCount =  [self.gprsDataArray count];
    Place *place = nil;
    for(int i = 0;i<totalCount;i++)
    {
        NSDictionary *item  = [self.gprsDataArray objectAtIndex:i];
        double lng = [[item objectForKey:@"lng"] doubleValue]/kGPSMaxScale;
        double lat = [[item objectForKey:@"lat"] doubleValue]/kGPSMaxScale;
        printf("[%lf,%lf]",lat,lng);
        //WGS2Mars(&lat, &lng);
        if(index == totalCount -1){
            CLLocationCoordinate2D coordinate2d;
            coordinate2d.latitude = lat;
            coordinate2d.longitude = lng;
            mStartCoordinate2d = transform(coordinate2d);
#if kLocationPhone
            _mStartName = [[DBManage  getSingletone] getLocationPointNameByLatitude:lat withLogtitude:lng withIndex:-1 withTag:YES];
            [[DBManage getSingletone]setDelegate:self];
#else
            if([_mStartName isEqualToString:@"未知"]){
                self.mStartName = [[DBManage  getSingletone] getLocationPointNameByLatitude:lat withLogtitude:lng withIndex:-1 withTag:YES];
                [[DBManage getSingletone]setDelegate:self];
            }
#endif
            if(_mStartName){
                place = [[Place alloc]init];
                place.description = @"";
                place.latitude = mStartCoordinate2d.latitude;
                place.longitude = mStartCoordinate2d.longitude;
                place.pointType = 0;
                place.name = _mStartName;
                [mMapView addPointToMap:place];
                //[place release];
                SafeRelease(place);
            }

        }
        if(index == 0){
            mEndSpeed = [[item objectForKey:@"speed"]floatValue];
            CLLocationCoordinate2D coordinate2d;
            coordinate2d.latitude = lat;
            coordinate2d.longitude = lng;
            mEndCoordinate2d = transform(coordinate2d);
#if kLocationPhone
            _mEndName = [[DBManage  getSingletone] getLocationPointNameByLatitude:lat withLogtitude:lng withIndex:-1 withTag:NO];
#else
            if([_mEndName isEqualToString:@"未知"]){
                self.mEndName = [[DBManage  getSingletone] getLocationPointNameByLatitude:lat withLogtitude:lng withIndex:-1 withTag:NO];
            }
#endif
            if(_mEndName && !self.isRunning)
            {
                place = [[Place alloc]init];
                place.latitude = mEndCoordinate2d.latitude;
                place.longitude = mEndCoordinate2d.longitude;
                place.name = _mEndName;
                place.pointType = 1;
                [mMapView addPointToMap:place];
                SafeRelease(place);
                //[mMapView addPinToMap:mEndCoordinate2d withName:mEndName];
                //[self didGetLocationData:mEndName withIndex:-1 withTag:NO];
            }
            
            
        }
        
        CLLocation *localpoint = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
        
        //CLLocation *end = [[[CLLocation alloc] initWithLatitude:lat ] autorelease];
        [gpsScaleArray addObject:localpoint];
        SafeRelease(localpoint);
        index++;
    }
    printf("\n\n");
#if 0
    if([gpsScaleArray count])
     [mMapView  showRouteWithPointsData:gpsScaleArray];
#else
//    if(!self.isRunning)
//        [mMapView centralMapwithPoints:gpsScaleArray];
    
    [mMapView centralMapwithPoint:mEndCoordinate2d];
    
    for(int i = 0;i<[self.gprsDataArray count]-1;i++){
        CGFloat startPoint = 0.f;
        CGFloat endPoint = 0.f;
        CLLocationCoordinate2D pointsToUse[2];
        for(int j =0 ;j<2;j++)
        {
           
            NSDictionary *item = [self.gprsDataArray objectAtIndex:i+j];
            CGFloat value = [[item objectForKey:@"speed"] floatValue];
           
            CLLocationCoordinate2D coords;
            double lng = [[item objectForKey:@"lng"] doubleValue]/kGPSMaxScale;
            double lat = [[item objectForKey:@"lat"] doubleValue]/kGPSMaxScale;
            coords.latitude = lat;
            coords.longitude = lng;
            coords = transform(coords);
            //printf("[%lf,%lf]",coords.latitude,coords.longitude);
            if(j== 0){
                startPoint = value;
                pointsToUse[0] = coords;
            }
            else{
                endPoint = value;
                pointsToUse[1] = coords;
            }
            
        }
        NSString *color = @"red";
        CGFloat avgSpeed = (startPoint+endPoint/2.f);
        if(avgSpeed < kLowSpeed){
            
        }
        else if(avgSpeed <kNormalSpeed){
            color = @"yeallow";
        }
        else{
            color = @"green";
        }

        
        [mMapView addRouterView:pointsToUse withCount:2 withColor:color withCenter:NO];
    }
#endif
    [self initMapPointData:data];
}

static int indexCount = 0;
- (void)updateUIRealTimeData:(NSDictionary*)data{
    
    CGFloat startPoint = mEndSpeed;
    CGFloat endPoint = 0.f;
    CGFloat degree = 0.f;
    static CGFloat startDegree = 0.f;
#if !TEST_RUNNING
    NSArray *cordPoints = [data objectForKey:@"gps"];
#else
    
    if(indexCount<=0){
        indexCount = [self.gprsDataArray count]-1;
    }
    data = [self.gprsDataArray objectAtIndex:indexCount--];
#endif
    [self setPanelUIByData:data];
    CLLocationCoordinate2D pointsToUse[2];
    
    pointsToUse[0] = mEndCoordinate2d;
    
    for(int i =0;i<1;i++){
        #if !TEST_RUNNING
        NSDictionary *item = [cordPoints objectAtIndex:i];
        #else
        NSDictionary *item = data;
        #endif
        endPoint = [[item objectForKey:@"speed"] floatValue];
        degree = [[item objectForKey:@"direct"]floatValue];
        CLLocationCoordinate2D coords;
        double lng = [[item objectForKey:@"lng"] doubleValue]/kGPSMaxScale;
        double lat = [[item objectForKey:@"lat"] doubleValue]/kGPSMaxScale;
        coords.latitude = lat;
        coords.longitude = lng;
        coords = transform(coords);
        pointsToUse[1] = coords;
    }
    NSString *color = @"red";
    CGFloat avgSpeed = (startPoint+endPoint/2.f);
    if(avgSpeed < kLowSpeed){
        
    }
    else if(avgSpeed <kNormalSpeed){
        color = @"yeallow";
    }
    else{
        color = @"green";
    }
    BOOL centerTag = NO;
    #if RunningCenter
    centerTag = YES;
    
    #endif
    
#if TEST_RUNNING
    color = @"red";
#endif
    [mMapView addRouterView:pointsToUse withCount:2 withColor:color withCenter:centerTag];
    
    //[mMapView addRouterView:pointsToUse withCount:2];
    mEndCoordinate2d = pointsToUse[1];
    mEndSpeed = endPoint;
    
    Place *place = [[Place alloc]init];
    place.description = @"";
    place.latitude = mEndCoordinate2d.latitude;
    place.longitude = mEndCoordinate2d.longitude;
    place.pointType = 2;
    place.degree = (degree+startDegree)/2.f;
    startDegree = degree;
    //place.name = _mStartName;
    
    [mMapView addMotionPointToMap:place];
    //[place release];
    SafeRelease(place);
    
   
    
    
    //[mMapView addMotionPointToMap:];
}
- (void)updateUIRealTimeCheck:(NSDictionary*)data{
    NSTimeInterval timer = 10.f;
#if TEST_RUNNING
    self.isRunning = YES;
    timer = 3.f;
#else
    
#endif
        if(self.isRunning){
            [self setNavgationBarTitle:@"正在驾驶"];
            //[self performSelectorInBackground:@selector(loadRouterHistoryData) withObject:nil];
            [self loadRouterHistoryData];
            self.realDataTimer = [NSTimer scheduledTimerWithTimeInterval:timer target:self selector:@selector(checkRunningData) userInfo:nil repeats:YES];
        }
        else{
            [self setNavgationBarTitle:@"最近驾驶"];
            //[self performSelectorInBackground:@selector(loadRouterHistoryData) withObject:nil];
            [self loadRouterHistoryData];
        }
}
#pragma mark -
#pragma mark get realtime data
- (void)checkRunningData{
    CarServiceNetDataMgr *cardShopMgr = [CarServiceNetDataMgr getSingleTone];
    //kNetStartShow(@"数据加载...", self.view);
    NSString *carId = [AppSetting  getUserCarId:nil];
    self.request = [cardShopMgr  getRouterRealTimeData:carId];
}
- (void)didGetLocationData:(id)sender withIndex:(NSInteger)index withTag:(BOOL)tag{
    if(index == -1){
        Place *place = [[Place alloc]init];
        place.name = sender;
        place.description = @"";
        if(tag){
            place.latitude = mStartCoordinate2d.latitude;
            place.longitude = mStartCoordinate2d.longitude;
            place.pointType = 0;
            //[mMapView addPinToMap:mStartCoordinate2d withName:sender];
            [mMapView addPointToMap:place];
            [mMapView addPointToMap:place];
        }
        else{
            if(!self.isRunning){
                place.latitude = mEndCoordinate2d.latitude;
                place.longitude = mEndCoordinate2d.longitude;
                place.pointType = 1;
                [mMapView addPointToMap:place];
            }
            //[mMapView addPinToMap:mEndCoordinate2d withName:sender];
        }
       
        
//        if(mEndName){
//            [mMapView addPinToMap:mEndCoordinate2d withName:mEndName];
//            //[self didGetLocationData:mEndName withIndex:-1 withTag:NO];
//        }
//        if(mStartName){
//            //[self didGetLocationData:mStartName withIndex:-1 withTag:YES];
//            
//        }

        SafeRelease(place);
    }
}
@end
