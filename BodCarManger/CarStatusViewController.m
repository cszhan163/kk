//
//  CarStatusViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-9-17.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#define kCheckViewPendingX  10.f
#define kCheckViewPendingY  10.f

#import "DDProgressView.h"
#import "CarDriveOilTableViewCell.h"


#import "CarStatusViewController.h"
#import "CarCheckTableViewCell.h"



#define kCheckResultLevelArray  @[@"car_check_status_top.png",@"car_check_status_mid.png",@"car_check_status_low.png"]
@interface CarStatusViewController (){

    UIProgressView       *checkProcessView;
    DDProgressView      *processView ;
    UILabel           *rotateSpeedLabel;
    UILabel           *temperatureLabel;
    UIImageView         *checkTagImageView ;
    UILabel           *checkProcessLabel;
    UILabel            *checkTimeLabel;
    BOOL isNeedReflush;
    
}
@property(nonatomic,strong)NSTimer             *timer;
@end

@implementation CarStatusViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(isNeedReflush){
        [self checkCacheData];
        isNeedReflush = NO;
    }
   
}
- (void)addObservers{
    [super addObservers];
    //[ZCSNotficationMgr postMSG:kUserDidLogOut obj:nil];
    [ZCSNotficationMgr addObserver:self call:@selector(clearLogoutData:) msgName:kUserDidLogOut];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(![[[UIApplication sharedApplication]delegate]checkCarInforData]){
        return;
    }
}
- (void)checkCacheData{

    NSString *userId = [AppSetting getLoginUserId];
    if(userId && ![userId isEqualToString:@""]){
        
        self.data = [NSDictionary dictionaryWithDictionary:[AppSetting getUserCarCheckData:userId]];
        if(self.data){
            id checkDataArray = [self.data objectForKey:@"conData"];
            //if([checkDataArray isKindOfClass:[NSArray class]])
            {
                self.dataArray = checkDataArray;
                [tweetieTableView reloadData];
            }
            [self setOtherUIData];
        }
        else{
        
        }
    }
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.delegate = self;
    
#if 1
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"car_bg.png");
    mainView.bgImage = bgImage;
#else
    mainView.mainFramView.backgroundColor = kAppUserBGWhiteColor;
#endif
    //mainView.alpha = 0.;
    [self setNavgationBarTitle:NSLocalizedString(@"车辆健康监测", @""
                                                 )];
    [self setRightBtnHidden:YES];
    [self setHiddenLeftBtn:YES];
    
    CGFloat currY =  kMBAppTopToolBarHeight;
    
    if(kDeviceCheckIphone5){
        currY = currY+10;
    }
    
    UIImageWithFileName(bgImage, @"car_check_header.png");
    
    UIImageView *headerView = [[UIImageView alloc]initWithImage:bgImage];
    
    headerView.frame = CGRectMake(kCheckViewPendingX,currY+kCheckViewPendingY ,bgImage.size.width/kScale, bgImage.size.height/kScale);
    headerView.userInteractionEnabled = YES;
    [self.view addSubview:headerView];
    SafeRelease(headerView);
    
    
    UIButton *checkButton = [UIComUtil createButtonWithNormalBGImageName:@"car_check_btn.png" withHightBGImageName:@"car_check_btn.png" withTitle:@"" withTag:0];
    
    [checkButton addTarget:self action:@selector(startCarHealthCheck:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:checkButton];
    checkButton.frame = CGRectMake(headerView.frame.size.width-100-16,7,checkButton.frame.size.width,checkButton.frame.size.height);
    
    CGFloat  headerY = 5.f;
    rotateSpeedLabel = [[UILabel alloc]initWithFrame:CGRectMake(38,headerY, 120.f, 20)];
    rotateSpeedLabel.font = [UIFont fontWithName:@"DIGIFACEWIDE" size:12];
    rotateSpeedLabel.text = @" 转速";
    rotateSpeedLabel.textColor = [UIColor whiteColor];
    rotateSpeedLabel.backgroundColor = [UIColor clearColor];
    
    
    [headerView addSubview:rotateSpeedLabel];
    SafeRelease(rotateSpeedLabel);
    
    temperatureLabel = [[UILabel alloc]initWithFrame:CGRectMake(38,headerY+20, 120.f, 20)];
    temperatureLabel.textColor = [UIColor whiteColor];
    temperatureLabel.font = kUserDigiFontSize(12);
    temperatureLabel.text = @" 水温";
    temperatureLabel.backgroundColor = [UIColor clearColor];
    
    [headerView addSubview:temperatureLabel];
    SafeRelease(temperatureLabel);
    
    
    currY = currY+headerView.frame.size.height+kCheckViewPendingX;
    
#if 0
    checkProcessView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    checkProcessView.progress = 0.4;
    //checkProcessView.progressTintColor = [UIColor blackColor];
    //checkProcessView.trackImage = [UIImage imageWith]HexRGB(44, 45, 47);
    checkProcessView.frame = CGRectMake(106,currY+57,186,5);
    [self.view addSubview:checkProcessView];
    KokSafeRelease(checkProcessView);
#else
    if(kDeviceCheckIphone5){
        currY = currY+20;
    }
   
    
   
    
    UIImageWithFileName(bgImage, @"car_check_header.png");
    
#endif
    //for headerLabel
//    UIImageWithFileName(bgImage, @"car_check_label.png");
//    UIImageView *checkProcessImageView = [[UIImageView alloc]initWithImage:bgImage];
//    
//    checkProcessImageView.frame = CGRectMake(106,currY+30 ,bgImage.size.width/kScale, bgImage.size.height/kScale);
//    checkProcessImageView.userInteractionEnabled = YES;
//    [self.view addSubview:checkProcessImageView];
//    SafeRelease(checkProcessImageView);
    
     currY = currY+30;
     CGFloat offsetX = 80;
    
    CGFloat adjustY = 0.f;
    if(kDeviceCheckIphone5){
        currY = currY+10.f;
        adjustY = -7.f;
    }
    
    
    CGRect textRect = CGRectMake(106,currY+adjustY,100, 15);
    UILabel *checkHeaderLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor whiteColor] withText:@"故障检测时间:" withFrame:textRect];
    checkHeaderLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:checkHeaderLabel];
    SafeRelease(checkHeaderLabel);
    
    
    textRect = CGRectMake(106+offsetX,currY+adjustY, 150, 15);
    checkTimeLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:14] withTextColor:HexRGB(36, 220, 0) withText:@"" withFrame:textRect];
    checkTimeLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:checkTimeLabel];
    SafeRelease(checkTimeLabel);
    
    //next line
    currY = currY+20.f;
    
    if(kDeviceCheckIphone5){
        currY = currY+10.f;
    }
    
    textRect = CGRectMake(106,currY+adjustY, 100, 15);
   checkHeaderLabel= [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor whiteColor]  withText:@"车辆故障检测:" withFrame:textRect];
    checkHeaderLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:checkHeaderLabel];
    SafeRelease(checkHeaderLabel);
    
    textRect = CGRectMake(106+offsetX,currY+adjustY, 150, 15);
    checkProcessLabel  = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:14] withTextColor:HexRGB(36, 220, 0) withText:@"未进行故障检测" withFrame:textRect];
    checkProcessLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:checkProcessLabel];
    SafeRelease(checkProcessLabel);
    

    CGFloat adjustProcess = 20.f;
    if(kDeviceCheckIphone5){
        adjustProcess = 30.f;
    }
    
    
    processView = [[DDProgressView alloc]initWithFrame:CGRectMake(106,currY+adjustProcess,186,10)];
    processView.innerColor = [UIColor greenColor];
    processView.outerColor = [UIColor whiteColor];
    processView.emptyColor = [UIColor blackColor];
    processView.progress = 0.0;
    processView.hidden = YES;
    [self.view addSubview:processView];
    
    CGFloat currOffsetY = 40.f;
    
    
    if(kDeviceCheckIphone5){
        currOffsetY = 50.f;
    }
    
    
    UIImageWithFileName(bgImage, @"car_check_status_default.png");

    
    checkTagImageView = [[UIImageView alloc]initWithImage:bgImage];
    checkTagImageView.frame = CGRectMake(23,currY-currOffsetY,bgImage.size.width/kScale, bgImage.size.height/kScale);
    [self.view addSubview:checkTagImageView];
    checkTagImageView.hidden = NO;
    SafeRelease(checkTagImageView);
    
    currY = currY+40;
    
    if(kDeviceCheckIphone5){
        currY = currY+20;
    }
  
    tweetieTableView.frame = CGRectMake(kCheckViewPendingX,currY,kDeviceScreenWidth-2*kCheckViewPendingX+1,202.f);
    UIImageWithFileName(bgImage, @"car_check_gridtable_bg.png");
    UIImageView *tableViewBg = [[UIImageView alloc]initWithImage:bgImage];
    [self.view  addSubview:tableViewBg];
    tableViewBg.frame = tweetieTableView.frame;
    [tweetieTableView removeFromSuperview];
    [tableViewBg addSubview:tweetieTableView];
    tweetieTableView.frame = CGRectMake(0.f,0.f,tableViewBg.frame.size.width,tableViewBg.frame.size.height+40);
    tableViewBg.clipsToBounds = YES;
    tableViewBg.userInteractionEnabled = NO;
    tweetieTableView.delegate = self;
    tweetieTableView.backgroundColor = [UIColor clearColor];
    tweetieTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tweetieTableView.clipsToBounds = YES;
    
    
#if 1
    UIImageWithFileName(bgImage, @"car_check_gridtable_header.png");
    
    UIImageView *tbHeaderView = [[UIImageView alloc]initWithImage:bgImage];
    
    tbHeaderView.frame = CGRectMake(kCheckViewPendingX,currY,bgImage.size.width/kScale, bgImage.size.height/kScale);
    [self.view addSubview:tbHeaderView];
    SafeRelease(tbHeaderView);
    //[tweetieTableView setTableHeaderView:tbHeaderView];
#endif
    CGFloat height = tbHeaderView.frame.size.height;
    tweetieTableView.normalEdgeInset = UIEdgeInsetsMake(height,0.f,0.f,0.f);
//    tweetieTableView.contentInset = UIEdgeInsetsMake(height,0.f,0.f,0.f);
    [self checkCacheData];
    //[self startCarHealthCheck:nil];
    //[self setRightTextContent:NSLocalizedString(@"Done", @"")];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark
- (void)startCarHealthCheck:(id)sender{
    
    //getCarCheckDataOk
    CarServiceNetDataMgr *cardShopMgr = [CarServiceNetDataMgr getSingleTone];
    //[self startShowLoadingView];
    kNetStartShow(@"数据加载...", self.view);
    NSString *userId = [AppSetting getLoginUserId];
    NSString *cardId = nil;
    if(userId){
        cardId = [AppSetting getUserCarId:userId];
    }
    if(cardId == nil||[cardId isEqualToString:@""]){
        return;
    }
    //NSString *carId = [AppSetting getUserCarId:];
    [cardShopMgr getCarCheckData:cardId];
     processView.hidden = NO;
    processView.progress = 0.f;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerUpdateProcess) userInfo:nil repeats:YES];
    [self.timer fire];
   
}
- (void)timerUpdateProcess{
    [self performSelectorOnMainThread:@selector(updateTimerUI) withObject:nil waitUntilDone:YES];
   
}
- (void)updateTimerUI{
     processView.progress += 0.2;
}
-(void)didNetDataOK:(NSNotification*)ntf
{
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];
    
    
    //NSString *resKey = [respRequest resourceKey];
    if(self.request ==respRequest && [resKey isEqualToString:kResCarCheckData])
    {
        self.data = data;
        self.dataArray = [data objectForKey:@"conData"];
        [self  performSelectorOnMainThread:@selector(updateUIData:) withObject:data waitUntilDone:NO ];
        //[mDataDict setObject:netData forKey:mMothDateKey];
        //}
        if([self.dataArray count]>0){
            NSTimeInterval interval = [[self.data objectForKey:@"time"]floatValue];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
            NSString *usrId = [AppSetting getLoginUserId];
            [AppSetting setUserCarCheckData:data withUserId:usrId];
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
            
            NSString *dateString = [dateFormat stringFromDate:date];
            
            [AppSetting setUserCarCheckTime:dateString withUserId:usrId];
        }
        kNetEnd(self.view);
        
    }
    
}
-(void)didNetDataFailed:(NSNotification*)ntf
{
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];
    if(self.request ==respRequest && [resKey isEqualToString:kResCarCheckData])
    {
        kNetEnd(self.view);
        //kNetEndWithErrorAutoDismiss(@"加载数据失败", 2.f);
        //[self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    
    //NE_LOG(@"warning not implemetation net respond");
}
- (void)updateUIData:(NSDictionary*)data{
    
    processView.progress = 1.0;
    processView.hidden = YES;
    [_timer invalidate];
    self.timer = nil;
    
    if([[data objectForKey:@"state"]intValue]== 0){
        checkProcessLabel.text = @"未获取检测数据";
        kUIAlertView(@"提示", @"请发动汽车后进行检测");
        return;
    }
    [tweetieTableView reloadData];
    //NSArray *economicData = [data objectForKey:@"conData"];
    [self setOtherUIData];
}
- (void)clearLogoutData:(NSNotification*)ntf{
    isNeedReflush = YES;
//    NSMutableDictionary *newDict = [NSMutableDictionary dictionary];
//    for(id item in self.data){
//        id data = [self.data objectForKey:item];
//        if([data isKindOfClass:[NSString class]]|| [data isKindOfClass:[NSNumber class]])
//            [newDict setObject:@"" forKey:item];
//        else if([data isKindOfClass:[NSArray class]]){
//            [newDict setObject:[NSArray array] forKey:item];
//        }
//    }
//    self.data = newDict;
}
- (void)setOtherUIData{

    NSString *usrId = [AppSetting getLoginUserId];
    NSString *timeStr = [AppSetting getUserCarCheckTime:usrId];
    if(timeStr)
        checkTimeLabel.text = timeStr;
    else
        checkTimeLabel.text = @"";
    NSString *rotateStr = [self.data objectForKey:@"RPM"];
    if(!rotateStr){
       rotateStr = @"";
    }
    rotateSpeedLabel.text = [NSString stringWithFormat:@"%@ 转",rotateStr];
    NSString *tempStr = [self.data objectForKey:@"temper"];
    if(!tempStr){
       tempStr = @"";
    }
    temperatureLabel.text = [NSString stringWithFormat:@"%@ 度",tempStr];
    int level = [[self.data objectForKey:@"level"] intValue];
    if(level>=1 && level<=3){
        UIImageWithFileName(UIImage *bgImage, kCheckResultLevelArray[level-1]);
        checkTagImageView.hidden = NO;
        checkTagImageView.image = bgImage;
    }
    else{
        UIImageWithFileName(UIImage*bgImage, @"car_check_status_default.png");
        checkTagImageView.hidden = NO;
        checkTagImageView.image = bgImage;
    }
    NSString *conculsion = [self.data objectForKey:@"conclusion"];
    if(conculsion){
        checkProcessLabel.text =  conculsion;
    }
    else{
        checkProcessLabel.text = @"";
    }
   
}

#pragma mark -
#pragma mark tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return  8;
    //return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    CarDriveOilTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
#if 0
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"CarDriveOilTableViewCell"
                                                        owner:self options:nil];
        for (id oneObject in nibArr)
            if ([oneObject isKindOfClass:[CarDriveOilTableViewCell class]])
                cell = (CarDriveOilTableViewCell*)oneObject;
        [cell setClounmLineColor:[UIColor greenColor]];
#else
        cell = [[CarCheckTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        SafeAutoRelease(cell);
        
#endif
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clipsToBounds = YES;
        cell.backgroundColor = [UIColor clearColor];
        
    }
    if(indexPath.row == 7){
        [cell setRowLineHidden:YES];
    }
    
    if(indexPath.row <[self.dataArray count]){
        NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
        NSString *name = [item objectForKey:@"name"];
        NSString *range = [item objectForKey:@"range"];
        NSString *value = [item objectForKey:@"value"];
        [cell setTableCellCloumn:0 withData:name];
        [cell setTableCellCloumn:1 withData:range];
        [cell setTableCellCloumn:2 withData:value];
        UILabel *nameLabel = [cell getClounmWithIndex:0];
        [nameLabel setTextAlignment:NSTextAlignmentLeft];
        CGRect originRect = nameLabel.frame;
        [nameLabel setFrame:CGRectMake(5.f,originRect.origin.y, originRect.size.width, originRect.size.height)];
    }
    else{
        
        [cell setTableCellCloumn:0 withData:@""];
        [cell setTableCellCloumn:1 withData:@""];
        [cell setTableCellCloumn:2 withData:@""];
    }
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
    UIImage *bgImage = nil;
    
    //
    //    NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
    //    NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
    //cell = (PlantTableViewCell*)cell;
    
	//cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 18.f+4.f;
}
-(void)didSelectorTopNavigationBarItem:(id)sender{
    switch ([sender tag]) {
        case  0:
            //[self.navigationController popViewControllerAnimated:YES];// animated:<#(BOOL)animated#>
			break;
        case 2:
        case 1:{
            [ZCSNotficationMgr postMSG:kStartShowSharedViewMSG obj:nil];
        }
    }

}
@end
