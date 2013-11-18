//
//  CardRouterViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-9-17.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarRouterViewController.h"

#import "CarRouterDetailViewController.h"
#import "PlantTableViewCell.h"
#import "OCCalendarView.h"
#import "DBManage.h"

#define kLeftPendingX  11
#define kTopPendingY  8
#define kHeaderItemPendingY 8

NSString* gDataArr[] = {@"12.5km",@"11km/h",@"87L",@"3h"};
@interface CarRouterViewController()<DBManageDelegate>{
    
}
@property(nonatomic,strong)NSDictionary *locationDict;
@end

@implementation CarRouterViewController
@synthesize currDate;
@synthesize currDateStruct;

#if __has_feature(objc_arc)
#else
- (void)dealloc{
    self.locationDict = nil;
    [super dealloc];
}
#endif


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if([self.dataArray count]==0){
    
        [self shouldLoadNewerData:tweetieTableView];
        //self.locationDict = [DBManage getLocationPointsData];
    }

}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //[super viewDidDisappear:animated];
    [[DBManage getSingletone]setDelegate:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[DBManage getSingletone]setDelegate:self];
//    CGPoint insertPoint = CGPointMake(167,50);
//    int width = 300;
//    int height = 250;
//
//    
//    OCCalendarView  *calView = [[OCCalendarView alloc] initAtPoint:insertPoint withFrame:CGRectMake(insertPoint.x-157, insertPoint.y, width, height) arrowPosition:OCArrowPositionNone];
//    [calView setSelectionMode:OCSelectionDateRange];
//    //[calView setArrowPosition:];
//    [self.view addSubview:[calView autorelease]];
//    return;
    
#if 1
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"car_bg.png");
    mainView.bgImage = bgImage;
#else
    mainView.mainFramView.backgroundColor = kAppUserBGWhiteColor;
#endif
    //mainView.alpha = 0.;
    if(navBarTitle == nil)
        [self setNavgationBarTitle:NSLocalizedString(@"Router", @""
                                                 )];
    [self setHiddenRightBtn:NO];
    [self setHiddenLeftBtn:NO];
    
    //[self setRightTextContent:NSLocalizedString(@"Done", @"")];
	// Do any additional setup after loading the view.
    tweetieTableView.frame = CGRectMake(kLeftPendingX,kMBAppTopToolBarHeight+kTopPendingY,kDeviceScreenWidth-2*kLeftPendingX,kMBAppRealViewHeight-kTopPendingY);
    UIImageWithFileName(bgImage, @"car_plant_bg.png");
    UIImageView *tableViewBg = [[UIImageView alloc]initWithImage:bgImage];
    [self.view  addSubview:tableViewBg];
    SafeRelease(tableViewBg);
    tableViewBg.frame = tweetieTableView.frame;
    [tweetieTableView removeFromSuperview];
    [tableViewBg addSubview:tweetieTableView];
    tweetieTableView.frame = CGRectMake(0.f,0.f,tableViewBg.frame.size.width,tableViewBg.frame.size.height);
    tableViewBg.clipsToBounds = YES;
    tableViewBg.userInteractionEnabled = YES;
    tweetieTableView.delegate = self;
    tweetieTableView.backgroundColor = [UIColor clearColor];
    tweetieTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tweetieTableView.clipsToBounds = YES;
    
#if 0
    UIView *headerView = [self addHeaderView:tableViewBg   withArrayData:nil];
    tweetieTableView.normalEdgeInset = UIEdgeInsetsMake(headerView.frame.size.height,0.f,0.f,0.f);
    NSError *error = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"plantData" ofType:@"geojson"];
    NSString *dataStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    //[NSJSONSerialization]
    
    NSDictionary *restData = [NSJSONSerialization   JSONObjectWithData:[dataStr dataUsingEncoding:NSUTF8StringEncoding ]options:NSJSONReadingMutableContainers  error:&error];
    
    self.dataArray = [[restData objectForKey:@"info"] objectForKey:@"data"];
    
    [tweetieTableView reloadData];
    
   
#else
    //[self  ]
  
#endif
    
}
- (UIView*)addHeaderView:(UIView*)parentView withArrayData:(NSArray*)dataArr{
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"car_plant_header.png");
    UIView *headerView = [[UIImageView alloc]initWithImage:bgImage];
    headerView.frame = CGRectMake(0., 0., bgImage.size.width/kScale, bgImage.size.height/kScale);
    [parentView addSubview:headerView];
    CGFloat startX = 5.f;
    for(int i =0;i<4;i++){
        NSString *fileName = [NSString stringWithFormat:@"plant_header_tag%d.png",i];
        UIImageWithFileName(bgImage,fileName);
        assert(bgImage);
        UIImageView *item = [[UIImageView alloc]initWithImage:bgImage];
        item.frame = CGRectMake(startX,kHeaderItemPendingY,bgImage.size.width/kScale, bgImage.size.height/kScale);
        startX += item.frame.size.width +5.f;
        UILabel *valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(startX,kHeaderItemPendingY, 40.f,14.f)];
        valueLabel.font = [UIFont systemFontOfSize:12];
        valueLabel.text = gDataArr[i];
        valueLabel.textColor = [UIColor whiteColor];
        valueLabel.backgroundColor = [UIColor clearColor];
        [parentView addSubview:valueLabel];
        SafeRelease(valueLabel);
        [parentView addSubview:item];
        SafeRelease(item);
        startX += 40.f+25.f;
    }
    return headerView;
}
#pragma mark -
#pragma mark tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	//return  5;
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    PlantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"PlantTableViewCell"
                                                        owner:self options:nil];
        for (id oneObject in nibArr)
            if ([oneObject isKindOfClass:[PlantTableViewCell class]])
                cell = (PlantTableViewCell*)oneObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clipsToBounds = YES;
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
    
    
    NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
    NSDictionary *data = item;//[item objectForKey:@"DayDetailInfo"];
    //cell = (PlantTableViewCell*)cell;
    NSString *flag = [data objectForKey:@"driveflg"];
    int time = [[data objectForKey:@"drivingLong"]intValue];
    //baoNormalFormat
    float distance = [[data objectForKey:@"distance"]floatValue];
    float oilvolume = [[data objectForKey:@"oil"]floatValue];
    
    CGPoint origin = cell.mTagImageView.frame.origin;
    if([flag isEqualToString:@"1"]){
        UIImageWithFileName(bgImage, @"tag-green.png");
        cell.mTagImageView.image = bgImage;
        
    }
    else{
        UIImageWithFileName(bgImage, @"tag-red.png");
        cell.mTagImageView.image = bgImage;
    
    }
    cell.mTagImageView.frame = CGRectMake(origin.x, origin.y,bgImage.size.width/kScale, bgImage.size.height/kScale);
    
    NSString *timeStr = [data objectForKey:@"startTime"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //[dateFormat setDateStyle:NSDateFormatterMediumStyle];
    //[dateFormat setTimeStyle:NSDateFormatterFullStyle];
    [dateFormat setDateFormat:@"yyyyMMddHHmmss"];
    NSString *temp = [dateFormat stringFromDate:[NSDate date]];
    NSDate *startDate = [dateFormat dateFromString:timeStr];
    [dateFormat setDateFormat:@"HH:mm"];
    NSString *dateStr = [dateFormat stringFromDate:startDate];
    /*
    NSArray *timeArr  = [timeStr componentsSeparatedByString:@" "];
    timeArr[1];
       */
    cell.mTagLabel.text = dateStr;//
    SafeRelease(dateFormat);
    
    //time
    origin = cell.mTimeImageView.frame.origin;
    if(time<100){
        UIImageWithFileName(bgImage, @"time-green.png");
        cell.mTimeImageView.image = bgImage;
        
    }
    else{
        UIImageWithFileName(bgImage, @"time-green.png");
        cell.mTimeImageView.image = bgImage;
        
    }
    cell.mTimeImageView.frame = CGRectMake(origin.x, origin.y,bgImage.size.width/kScale, bgImage.size.height/kScale);
    
    NSString *latLogStr = [data objectForKey:@"startadr2"];
    NSArray *latLogArr  = [latLogStr componentsSeparatedByString:@","];
    /*
    mStartPoint.latitude = 
	mStartPoint.longitude = [latLogArr[0]floatValue]/kGPSMaxScale;
     */
    //NSString *startLocationKey = @"";
    NSString *startLocation = [[DBManage getSingletone] getLocationPointNameByLatitude:[latLogArr[1]floatValue]/kGPSMaxScale withLogtitude:[latLogArr[0]floatValue]/kGPSMaxScale withIndex:indexPath.row  withTag:YES];
    if(startLocation == nil){
        startLocation = @"未知";
    }
    latLogStr = [data objectForKey:@"endadr2"];
    latLogArr  = [latLogStr componentsSeparatedByString:@","];
    /*
     mStartPoint.latitude =
     mStartPoint.longitude = [latLogArr[0]floatValue]/kGPSMaxScale;
     */
    //NSString *startLocationKey = @"";
    NSString *endLocation = [[DBManage getSingletone] getLocationPointNameByLatitude:[latLogArr[1]floatValue]/kGPSMaxScale withLogtitude:[latLogArr[0]floatValue]/kGPSMaxScale withIndex:indexPath.row withTag:NO];
    if(endLocation == nil){
        endLocation = @"未知";
    }
    cell.mTimeLabel.text = [NSString stringWithFormat:@"%@",[self baoNormalFormat:[data objectForKey:@"drivingLong"]]];
    cell.mStartLabel.text = [NSString stringWithFormat:@"始: %@",startLocation];
    cell.mEndLabel.text = [NSString stringWithFormat:@"终: %@",endLocation];
    //[data objectForKey:@"endadr"];
    
    //distance
    origin = cell.mDistanceImageView.frame.origin;
    if(time<10.0){
        UIImageWithFileName(bgImage, @"distance.png");
        cell.mDistanceImageView.image = bgImage;
        
    }
    else{
        UIImageWithFileName(bgImage, @"distance-red.png");
        cell.mDistanceImageView.image = bgImage;
        
    }
    cell.mDistanceImageView.frame = CGRectMake(origin.x, origin.y,bgImage.size.width/kScale, bgImage.size.height/kScale);
    
    cell.mDistanceLabel.text = [NSString stringWithFormat:@"%.1lfkm",distance];
    //oil
    origin = cell.mOilImageView.frame.origin;
    if(oilvolume<15.0){
        UIImageWithFileName(bgImage, @"oil.png");
        cell.mOilImageView.image = bgImage;
        
    }
    else{
        UIImageWithFileName(bgImage, @"oil-red.png");
        cell.mOilImageView.image = bgImage;
        
    }
    cell.mOilImageView.frame = CGRectMake(origin.x, origin.y,bgImage.size.width/kScale, bgImage.size.height/kScale);
    
    cell.mOilLabel.text = [NSString stringWithFormat:@"%.1lfL",oilvolume];
    
	//cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CarRouterDetailViewController *vc = [[CarRouterDetailViewController alloc]initWithNibName:nil bundle:nil];
    [vc  setNavgationBarTitle:navBarTitle];
    vc.delegate = self;
    NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
    //NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
    vc.mData = item;
#if kMapHasTab
    [self.navigationController pushViewController:vc animated:YES];
#else
    
    [ZCSNotficationMgr postMSG:kPushNewViewController obj:vc];
#endif
    //[self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SafeRelease(vc);
}
#pragma mark -
#pragma mark delegate

- (void)didGetLocationData:(NSString*)name withIndex:(NSInteger)index withTag:(BOOL)tag{
    PlantTableViewCell *cell = (PlantTableViewCell*)[tweetieTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    if(tag){
        cell.mStartLabel.text = [NSString stringWithFormat:@"始: %@",name];;
    }
    else{
        cell.mEndLabel.text =  [NSString stringWithFormat:@"终: %@",name];;
    }
}
#pragma mark -
#pragma mark net work
- (void)shouldLoadNewerData:(UITableView*)tableView{

    CarServiceNetDataMgr *cardShopMgr = [CarServiceNetDataMgr getSingleTone];
    
    //[self startShowLoadingView];
    kNetStartShow(@"数据加载...", self.view);
    [super shouldLoadNewerData:tweetieTableView];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
             //catStr,@"cat",
             currDate, @"date",
             // @"page",@"1",
             // @"records",@""
             nil];
    //self.request = [cardShopMgr  getDetailByDay:param];
    NSString *day = [NSString stringWithFormat:@"%d",currDateStruct.day];
    NSString *month = [NSString stringWithFormat:@"%d",currDateStruct.month];
    NSString *year = [NSString stringWithFormat:@"%d",currDateStruct.year];
    [cardShopMgr getRouterDataByDay:day withMoth:month withYear:year];
//    if(isNeedHeaderView)
//    {
//        self.adRequest = [cardShopMgr getHomePageAd:nil];
//    }

}
-(void)didNetDataOK:(NSNotification*)ntf
{
    
    
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];//[respRequest resourceKey];
    //NSString *resKey = [respRequest resourceKey];
    if(self.request ==respRequest && [resKey isEqualToString:kResRouterDataDay])
    {
//        if ([self.externDelegate respondsToSelector:@selector(commentDidSendOK:)]) {
//            [self.externDelegate commentDidSendOK:self];
//        }
//        kNetEndSuccStr(@"评论成功",self.view);
//        [self dismissModalViewControllerAnimated:YES];
        
        self.dataArray = [data objectForKey:@"data"];
        for(id item in self.dataArray){
            /*
            NSString *latLogStr = [item objectForKey:@"startadr2"];
            NSArray *latLogArr  = [latLogStr componentsSeparatedByString:@","];
            
            double lat = [latLogArr[1]floatValue]/kGPSMaxScale;
            double  lng = [latLogArr[0]floatValue]/kGPSMaxScale;
            
            [[DBManage getSingletone] getLocationDataFromVendorWithLatitude:lat withLotitude:lng];
            
            latLogStr = [item objectForKey:@"endadr2"];
            latLogArr  = [latLogStr componentsSeparatedByString:@","];
            
            lat = [latLogArr[1]floatValue]/kGPSMaxScale;
            lng = [latLogArr[0]floatValue]/kGPSMaxScale;
            [[DBManage getSingletone] getLocationDataFromVendorWithLatitude:lat withLotitude:lng];
                    */
            //[self getPlaceNameByPositionwithLatitue:lat withLongitude:lng];
        }
        [tweetieTableView reloadData];
        kNetEnd(self.view);

    }
    if(self.request ==respRequest && [resKey isEqualToString:@"addreply"])
    {
//        if ([self.externDelegate respondsToSelector:@selector(commentDidSendOK:)]) {
//            [self.externDelegate commentDidSendOK:self];
//        }
//        kNetEndSuccStr(@"回复成功",self.view);
//        [self dismissModalViewControllerAnimated:YES];
    }
    
    //self.view.userInteractionEnabled = YES;
}
-(void)didNetDataFailed:(NSNotification*)ntf
{
    //kNetEndWithErrorAutoDismiss(@"", 2.f);
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];
    if(self.request ==respRequest && [resKey isEqualToString:kResRouterDataDay])
    {
        kNetEnd(self.view);
    }
  
    
    //NE_LOG(@"warning not implemetation net respond");
}
-(void)didRequestFailed:(NSNotification*)ntf
{
    //[self stopShowLoadingView];
    kNetEnd(self.view);
}
-(void)didSelectorTopNavigationBarItem:(id)sender{
    
    switch ([sender tag]) {
        case  0:
            //[self.navigationController popViewControllerAnimated:YES];// animated:<#(BOOL)animated#>
			break;
        case 2:
        case 1:{
            /*
            [ZCSNotficationMgr postMSG:kPopAllViewController obj:nil];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    */
            
        }
    }

}
-(NSString*) baoNormalFormat:(NSString*)srcStr{
    int time = [srcStr intValue];
    if(time<60){
        return [NSString stringWithFormat:@"%dmin",time];
    }
    else if(time>60 && time<60*24)
    {
        return [NSString stringWithFormat:@"%0.1lfhour",time/60.f];
    }
    else{
        return [NSString stringWithFormat:@"%0.1lfday",time/(60.*24)];
    }
}

//-(void)getPlaceNameByPositionwithLatitue:(double)lat withLongitude:(double)lng{
//    
//    
//}
@end
