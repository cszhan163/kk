//
//  CarRouterDateViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-9-18.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarRouterDateViewController.h"
#import "OCCalendarViewController.h"
#import "OCCalendarView.h"
#import "CarRouterViewController.h"
#import "CarRouterDetailViewController.h"


#ifdef Infinite
#import "IAInfiniteGridView.h"
#import "XLCycleScrollView.h"
#endif


#define kCalendarWidth  (kDeviceScreenWidth-18.f)
#define kCalendarHeight 250
#define kNumberCalViewTag 999
@interface CarRouterDateViewController ()<OCCalendarDelegate,
    IAInfiniteGridDataSource,
    XLCycleScrollViewDatasource,
    XLCycleScrollViewDelegate,
    OCDaysViewDelegate,
    UIBaseViewControllerDelegate>{
    OCCalendarView *calView;
    IAInfiniteGridView  *gridView;
    XLCycleScrollView   *csView;
        BOOL isRunning ;
        
        
}

@property(nonatomic,strong)NSMutableDictionary   *mHasDataDict;
@property(nonatomic,strong)IAInfiniteGridView *gridView;

@end

@implementation CarRouterDateViewController
@synthesize mHasDataDict;
@synthesize gridView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.mDataDict = [NSMutableDictionary dictionary];
        self.mHasDataDict = [NSMutableDictionary dictionary];
       
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self checkDataChange];
}
//#define FIRST
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    [self setHiddenLeftBtn:NO];
    isTodayMonth = YES;
    NSString *barTitle  = [NSString stringWithFormat:@"%d年%02d月",self.mCurrDate.year,self.mCurrDate.month];
    [self setNavgationBarTitle:barTitle];
    
    [ZCSNotficationMgr postMSG:KNewMessageFromMSG obj:@"10"];
   // self.mMothDateKey = [NSString stringWithFormat:kDateFormart,self.mCurrDate.year,self.mCurrDate.month];
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"car_bg.png");
    mainView.bgImage = bgImage;
    UIImageWithFileName(bgImage, @"router_today_date.png");
    [super setNavgationBarRightBtnImage:bgImage forStatus:UIControlStateNormal];
    [super setNavgationBarRightBtnImage:bgImage forStatus:UIControlStateSelected];
    CGRect rect = self.rightBtn.frame;
    self.rightBtn.frame = CGRectMake(kDeviceScreenWidth-10.f-bgImage.size.width/kScale, rect.origin.y, bgImage.size.width/kScale, bgImage.size.height/kScale);
    
    UIButton *preBtn = [UIComUtil createButtonWithNormalBGImageName:@"router_page_up.png" withHightBGImageName:@"router_page_up.png" withTitle:@"" withTag:0];
    [preBtn addTarget:self action:@selector(didScrollerToPreMoth:) forControlEvents:UIControlEventTouchUpInside];
    preBtn.frame = CGRectMake(90.f,12.f,preBtn.frame.size.width, preBtn.frame.size.height);
    [mainView.topBarView addSubview:preBtn];
    UIButton *nextBtn = [UIComUtil createButtonWithNormalBGImageName:@"router_page_down.png" withHightBGImageName:@"router_page_down.png" withTitle:@"" withTag:1];
    [mainView.topBarView addSubview:nextBtn];
    
    [nextBtn addTarget:self action:@selector(didScrollerToAfterMoth:) forControlEvents:UIControlEventTouchUpInside];
    
    nextBtn.frame = CGRectMake(220.f,12.f,nextBtn.frame.size.width, nextBtn.frame.size.height);
    [mainView.topBarView addSubview:nextBtn];
 #ifdef  FIRST   
    //Now we're going to optionally set the start and end date of a pre-selected range.
    //This is totally optional.
	NSDateComponents *dateParts = [[NSDateComponents alloc] init];
	[dateParts setMonth:mCurrDate.month];
	[dateParts setYear:mCurrDate.year];
	[dateParts setDay:9];
    
	NSDate *sDate = [calendar dateFromComponents:dateParts];
	[dateParts release];
    
    
    dateParts = [[NSDateComponents alloc] init];
	[dateParts setMonth:mCurrDate.month];
	[dateParts setYear:mCurrDate.year];
	[dateParts setDay:11];
    
	NSDate *eDate = [calendar dateFromComponents:dateParts];
	[dateParts release];
    
    dateParts = [[NSDateComponents alloc] init];
	[dateParts setMonth:mCurrDate.month];
	[dateParts setYear:mCurrDate.year];
	[dateParts setDay:3];
    
	sDate = [calendar dateFromComponents:dateParts];
	[dateParts release];
    
    
    dateParts = [[NSDateComponents alloc] init];
	[dateParts setMonth:mCurrDate.month];
	[dateParts setYear:mCurrDate.year];
	[dateParts setDay:6];
    
	eDate = [calendar dateFromComponents:dateParts];
	[dateParts release];
    
    //[calView addStartDate:sDate endDate:eDate withTag:0];
    
    dateParts = [[NSDateComponents alloc] init];
	[dateParts setMonth:mCurrDate.month];
	[dateParts setYear:mCurrDate.year];
	[dateParts setDay:30];
    sDate = [calendar dateFromComponents:dateParts];
	[dateParts release];
    //Here's where the magic happens

    OCCalendarViewController *calVC = [[OCCalendarViewController alloc] initAtPoint:CGPointMake(167, 90) inView:self.view arrowPosition:OCArrowPositionNone];
    calVC.delegate = self;
	//Test ONLY
	calVC.selectionMode = OCSelectionDateRange;
      [calVC setStartDate:sDate];
    [calVC setEndDate:eDate];
    [self.view addSubview:calVC.view];
    calVC.view.frame = CGRectMake(10.f,10.f,390,300);
    
#else
   
#if 0
    
    CGPoint insertPoint = CGPointMake(167,50);
    int width = 300;
    int height = 250;
    calView = [[OCCalendarView alloc] initAtPoint:insertPoint withFrame:CGRectMake(insertPoint.x-157, insertPoint.y, width, height) arrowPosition:OCArrowPositionNone];
    [calView setSelectionMode:OCSelectionDateRange];
    //[calView setArrowPosition:];
    [self.view addSubview:[calView autorelease]];
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] init];
    tapG.delegate = self;
    [calView addGestureRecognizer:[tapG autorelease]];
    [calView setUserInteractionEnabled:YES];
    
    [calView setDelegate:self];
    [self.view addSubview:calView];
#else
    /*
    self.gridView = [[IAInfiniteGridView alloc]initWithFrame:CGRectMake(9.f,kMBAppTopToolBarHeight+9.f,kCalendarWidth,kCalendarHeight)];
    self.gridView.dataSource = self;
    [self.gridView startGetPagesView];
    gridView.backgroundColor = [UIColor redColor];
    [self.gridView setPaging:YES];
    [self.gridView jumpToIndex:0];
       [self.view addSubview:self.gridView];
       */
    csView = [[XLCycleScrollView alloc] initWithFrame:CGRectMake(9.f,kMBAppTopToolBarHeight+9.f,kCalendarWidth,kCalendarHeight)];
    csView.delegate = self;
    csView.datasource = self;
    csView.pageControl.hidden = YES;
    [self.view addSubview:csView];
    SafeRelease(csView);
    
#endif
    
    
    
#if 0
    [calView setStartDate:sDate];
    [calView setEndDate:eDate];
#else
    //[calView addStartDate:sDate endDate:eDate];
#endif
    //[calView addStartDate:sDate endDate:sDate];
    
   
#endif
    CGFloat currY = 250.f+40.f+25;
    UIImageWithFileName(bgImage, @"today-small.png");
    UIImageView *imageView = [[UIImageView alloc]initWithImage:bgImage];
    [self.view addSubview:imageView];
    imageView.frame = CGRectMake(60.f,currY, bgImage.size.width/kScale, bgImage.size.height/kScale);
    SafeRelease(imageView);
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(60.f+bgImage.size.width+7,currY-5,120.f,20.f)];
    label.text = @"今天";
    label.backgroundColor= [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label];
    SafeRelease(label);
    
    currY = 250.f+40.f+50.f;
    UIImageWithFileName(bgImage, @"regular-small.png");
    
    imageView = [[UIImageView alloc]initWithImage:bgImage];
    [self.view addSubview:imageView];
    imageView.frame = CGRectMake(60.f,currY, bgImage.size.width/kScale, bgImage.size.height/kScale);
    SafeRelease(imageView);
    label = [[UILabel alloc]initWithFrame:CGRectMake(60.f+bgImage.size.width+7,currY-5,120.f,20.f)];
    label.text = @"正常行使日";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label];
    SafeRelease(label);
    
    currY = currY + 25;
    UIImageWithFileName(bgImage, @"faulty-small.png");
    
    imageView = [[UIImageView alloc]initWithImage:bgImage];
    [self.view addSubview:imageView];
    imageView.frame = CGRectMake(60.f,currY, bgImage.size.width/kScale, bgImage.size.height/kScale);
    SafeRelease(imageView);
    label = [[UILabel alloc]initWithFrame:CGRectMake(60.f+bgImage.size.width+7,currY-5,120.f,20.f)];
    label.text = @"报警日/故障日";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label];
    SafeRelease(label);
	// Do any additional setup after loading the view.
}
#pragma mark -
- (void)didScrollerToPreMoth:(id)sender{
    [csView scrollerToPrePage];

}
- (void)didScrollerToAfterMoth:(id)sender{
    [csView scrollerToNextPage];
}
- (void)returnToTodayMonth:(id)sender{

}
-(void)didSelectorTopNavigationBarItem:(id)sender{
    switch ([sender tag]) {
        case  0:
            
            //isRunning = NO;
            if([self.data objectForKey:@"endTime"] == 0){//the card is Running
                isRunning = YES;
            }
            else{
                
            }
            //[self.navigationController popViewControllerAnimated:YES];// animated:<#(BOOL)animated#>
            CarRouterDetailViewController *vc = [[CarRouterDetailViewController alloc]initWithNibName:nil bundle:nil];
            vc.delegate = self;
            vc.mData = self.data;
            vc.isLatest = YES;
            vc.isRunning = isRunning;
#if kMapHasTab
            [self.navigationController pushViewController:vc animated:YES];
#else
            [ZCSNotficationMgr postMSG:kPushNewViewController obj:vc];
#endif
            SafeRelease(vc);
			break;
        case 2:
        case 1:{
            [csView resetInitStatus];
            self.mCurrDate = self.mTodayDate;
            self.mMothDateKey = [NSString stringWithFormat:kDateFormart,self.mCurrDate.year,self.mCurrDate.month];
            isNeedReflush = YES;
            [self checkDataChange];
            
            //[ZCSNotficationMgr postMSG:kStartShowSharedViewMSG obj:nil];
        }
    }
    
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

    if(senderView.nolimitIndex == 0){
        isTodayMonth = YES;
    }
    else{
        isTodayMonth = NO;
    }
    int month = self.mTodayDate.month +senderView.nolimitIndex+index;
    int year = self.mTodayDate.year;
    [self checkAdjustDate:senderView.nolimitIndex withMonth:&month withYear:&year];
    CGPoint insertPoint = CGPointMake(167,50);
    int width = kCalendarWidth;
    int height = kCalendarHeight;
    OCCalendarView *tempCalView = [[OCCalendarView alloc] initAtPoint:insertPoint withFrame:CGRectMake(0.f,0.f, width, height) arrowPosition:OCArrowPositionNone];
    [tempCalView setSelectionMode:OCSelectionDateRange];
    //[calView setArrowPosition:];
    //[self.view addSubview:calView];
    [tempCalView setDateKey:[NSString stringWithFormat:kDateFormart,year,month]];
    [tempCalView setDelegate:self];
    [tempCalView setUserInteractionEnabled:YES];
    /*
     UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] init];
     tapG.delegate = self;
     [calView addGestureRecognizer:[tapG autorelease]];
     */
    [tempCalView setDataWithYear:year withMonth:month];
    //[tempCalView setInitDate:curMothDict];
    //[tempCalView setTag:kNumberCalViewTag];
    //[grid addSubview:calView];
    //SafeRelease(tempCalView);
    return SafeAutoRelease(tempCalView);
}
- (void)didEndScrollerView:(XLCycleScrollView*)senderView{

    if(currIndex == senderView.nolimitIndex){
        
    }
    else{
        int month = self.mTodayDate.month +senderView.nolimitIndex;
        int year = self.mTodayDate.year;
        [self checkAdjustDate:senderView.nolimitIndex withMonth:&month withYear:&year];
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

    }
   
}
#pragma mark-
#pragma mark --scrollerview
#pragma mark - Data Source Methods
#define TEST_SColler 0
- (UIView *)infiniteGridView:(IAInfiniteGridView *)gridView forIndex:(NSInteger)gridIndex {
    UIView *grid = [gridView dequeueReusableGrid];
    if (grid == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, [self infiniteGridSize].width, [self infiniteGridSize].height);
        
        grid = [[UIView alloc] initWithFrame:frame];
#if TEST_SColler
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:frame];
        [numberLabel setBackgroundColor:[UIColor clearColor]];
        [numberLabel setFont:[UIFont boldSystemFontOfSize:([self infiniteGridSize].height * .4)]];
        [numberLabel setTextColor:[UIColor whiteColor]];
        [numberLabel setTextAlignment:NSTextAlignmentCenter];
        [numberLabel setTag:kNumberCalViewTag];
        [grid addSubview:numberLabel];
        SafeRelease(numberLabel);
        
#else
        
        
        CGPoint insertPoint = CGPointMake(167,50);
        int width = kCalendarWidth;
        int height = kCalendarHeight;
        /*
                UIView *testView = [[UIView alloc] initWithFrame:CGRectMake((kDeviceScreenWidth-width)/2.f, insertPoint.y, width, height)];
                [grid addSubview:testView];
            */
        calView = [[OCCalendarView alloc] initAtPoint:insertPoint withFrame:CGRectMake(0.f,0.f, width, height) arrowPosition:OCArrowPositionNone];
        [calView setSelectionMode:OCSelectionDateRange];
        //[calView setArrowPosition:];
        //[self.view addSubview:calView];
        [calView setDelegate:self];
        [calView setUserInteractionEnabled:YES];
          /*
                UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] init];
                tapG.delegate = self;
                [calView addGestureRecognizer:[tapG autorelease]];
                */
        [calView setTag:kNumberCalViewTag];
        [grid addSubview:calView];
        SafeRelease(calView);
#endif
    }
    
    // set properties
#if TEST_SColler
    NSInteger mods = gridIndex % [self numberOfInfiniteGrids];
    if (mods < 0) mods += [self numberOfInfiniteGrids];
    CGFloat red = mods * (1 / (CGFloat)[self numberOfInfiniteGrids]);
    UILabel *numberLabel = (UILabel *)[grid viewWithTag:kNumberCalViewTag];
    grid.backgroundColor = [UIColor colorWithRed:red green:0.0 blue:0.0 alpha:1.0];
    [numberLabel setText:[NSString stringWithFormat:@"[%d]", gridIndex]];
     
#else
    OCCalendarView *carlendarView = (OCCalendarView *)[grid viewWithTag:kNumberCalViewTag];
    if(gridIndex>0){
        //[self didTouchAfterMoth:day];
    }
    else{
    
    }
    NSLog(@"scroller update:%d",gridIndex);
#endif
    return grid;
}

- (NSUInteger)numberOfInfiniteGrids {
    return 2;
}

- (CGSize)infiniteGridSize {
    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        return CGSizeMake(300.0, 300.0);
//    }
    return CGSizeMake(kCalendarWidth, kCalendarHeight);
}
int lastIndex = -1;
int lastDirect = -1;
- (void)didScrollerView:(IAInfiniteGridView*)gridView withDirection:(int)direction withIndex:(int)index{
    if(lastIndex == index){
        if(lastDirect != direction && lastDirect == 0){
            NSLog(@"not update %d",lastIndex -1);
        }
        else if(lastDirect != direction && lastDirect == 1){
          NSLog(@"not update %d",lastIndex +1);
        }
    }
    else{
        NSLog(@"%d",index);
        
    }
    lastIndex = index;
    lastDirect = direction;
}
#pragma mark -
#pragma mark - choose day
- (void)didChooseCalendarDay:(NSDictionary*)day{
    
    
    if(![self.mHasDataDict objectForKey:[day objectForKey:@"day"]]){
        
        return;
        
    }
    
    NSString *title = [NSString stringWithFormat:@"%@年%@月%@日",[day objectForKey:@"year"],[day objectForKey:@"month"],[day objectForKey:@"day"]];
    
    CarRouterViewController *dayRounterVc = [[CarRouterViewController alloc]init];
    [dayRounterVc setNavgationBarTitle:title];
    dayRounterVc.currDate = [NSString stringWithFormat:@"%@%02d%02d",[day objectForKey:@"year"],[[day objectForKey:@"month"]intValue],[[day objectForKey:@"day"]intValue]];
    DateStruct date ;
    date.day = [[day objectForKey:@"day"]intValue];
    date.month = [[day objectForKey:@"month"]intValue];
    date.year = [[day objectForKey:@"year"]intValue];
    dayRounterVc.currDateStruct = date;
    
    [self.navigationController pushViewController:dayRounterVc animated:YES];
    SafeRelease(dayRounterVc);

    
    /*
    CarRouterDetailViewController *vc = [[CarRouterDetailViewController alloc]initWithNibName:nil bundle:nil];
    NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
    NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
    vc.mData = data;
    [ZCSNotficationMgr postMSG:kPushNewViewController obj:vc];
     */
    //[self.navigationController pushViewController:vc animated:YES];
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//- (void)checkDataChange{
//
//#if 0
//    NSArray * dataArray = [NSArray arrayWithObject:
//                           [NSDictionary dictionary]]
//    mDataDict = [NSDictionary dictionaryWithObjectsAndKeys:
//                 
//                 , nil];
//#endif
////    NSMutableArray *data = [mDataDict objectForKey:mMothDateKey] ;
////    if(data== nil){
////        [self refulshNetData];
////    }
////    else{
////        if(!isNeedReflush)
////            return;
////        [self updateUIData:data];
////    }
//    [super]
//}

- (void)didTouchPreMoth:(NSDictionary*)day{
//    isNeedReflush = YES;
//    mCurrDate.year = [[day objectForKey:@"year"]intValue];
//    mCurrDate.month = [[day objectForKey:@"month"]intValue];
//     self.mMothDateKey = [NSString stringWithFormat:@"%d%02d",mCurrDate.year,mCurrDate.month];
//    
//    [self checkDataChange];
    [super didTouchAfterMoth:day];
}
- (void)didTouchAfterMoth:(NSDictionary *)day{

//    isNeedReflush = YES;
//    mCurrDate.year = [[day objectForKey:@"year"]intValue];
//    mCurrDate.month = [[day objectForKey:@"month"]intValue];
//     self.mMothDateKey = [NSString stringWithFormat:@"%d%02d",mCurrDate.year,mCurrDate.month];
//    [self checkDataChange];

    [super didTouchAfterMoth:day];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    CGPoint point = [touch  locationInView:self];
//    NE_LOGPOINT(point);
//    //    UITouch *touch = [touches anyObject];
//    //    CGPoint point = [touch locationInView:self];
//    if(CGRectContainsPoint(daysView.frame,point))
//        [daysView getTouchDayViewByPoint:point withParentView:self];
    [calView startConvertPoint:touch];
    return YES;
}
#pragma mark -
#pragma mark net work
- (void)refulshNetData{
    
    
    CarServiceNetDataMgr *cardShopMgr = [CarServiceNetDataMgr getSingleTone];
    //[self startShowLoadingView];
    NSString *mothParm = [NSString stringWithFormat:@"%d%02d",self.mCurrDate.year,self.mCurrDate.month];
    kNetStartShow(@"数据加载...", self.view);
    //[super shouldLoadNewerData:tweetieTableView];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           //catStr,@"cat",
                           //mothParm, @"month",
                           [NSString stringWithFormat:@"%d",self.mCurrDate.year],@"year",
                           [NSString stringWithFormat:@"%d",self.mCurrDate.month],@"month",
                           // @"page",@"1",
                           // @"records",@""
                           nil];
    self.request = [cardShopMgr  getDetailByMonth:param];
    
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
    NSString *resKey = [obj objectForKey:@"key"];
    //NSString *resKey = [respRequest resourceKey];
    if(self.request ==respRequest && [resKey isEqualToString:kResRouterDataMoth])
    {
        //        if ([self.externDelegate respondsToSelector:@selector(commentDidSendOK:)]) {
        //            [self.externDelegate commentDidSendOK:self];
        //        }
        //        kNetEndSuccStr(@"评论成功",self.view);
        //        [self dismissModalViewControllerAnimated:YES];
        /*
        
        self.dataArray =
        
        [tweetieTableView reloadData];
         */
        isNeedReflush = YES;
    
        NSArray *netData = data;//[data objectForKey:@"data"];
        
      
        [self  performSelectorOnMainThread:@selector(updateUIData:) withObject:netData waitUntilDone:NO ];
        [self.mDataDict setObject:netData forKey:self.mMothDateKey];
        //}
        kNetEnd(self.view);
        
    }
    if(self.request ==respRequest && [resKey isEqualToString:kResRouterLatest])
    {
        BOOL isRunning = NO;
        if([data objectForKey:@"endTime"] == 0){//the card is Running
            isRunning = YES;
        }
        else{
            
        }
        if([[data objectForKey:@"tripId"]intValue] !=0){
            self.data = data;
            CarRouterDetailViewController *vc = [[CarRouterDetailViewController alloc]initWithNibName:nil bundle:nil];
            vc.delegate = self;
            vc.mData = data;
            vc.isLatest = YES;
            vc.isRunning = isRunning;
#if kMapHasTab
            [self.navigationController pushViewController:vc animated:YES];
#else
            [ZCSNotficationMgr postMSG:kPushNewViewController obj:vc];
#endif
            SafeRelease(vc);
        }
    }
}
-(void)didNetDataFailed:(NSNotification*)ntf
{
    //kNetEnd(@"", 2.f);
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];
    if(self.request ==respRequest && [resKey isEqualToString:kResRouterDataMoth])
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

   
    [self.mHasDataDict  removeAllObjects];
    NSMutableDictionary *uiDataDict = [NSMutableDictionary dictionary];
    NSMutableString *driveOk = [NSMutableString stringWithString:@""];
    NSMutableString *driveFailed = [NSMutableString stringWithString:@""];
    for(NSDictionary *item in netData){
        
        NSString *flag = @"";
        DateStruct dateStruct;
#if  0
        NSString *date = @"";
        NSDictionary *data = [item objectForKey:@"DayInfo"];
        date = [data objectForKey:@"day"];
        flag= [data objectForKey:@"driveflg"];
        NSArray *dateArray = [date componentsSeparatedByString:@"-"];
       
        dateStruct.day = [dateArray[2]intValue];
#else
        dateStruct.day = [[item objectForKey:@"day"]intValue];
        flag = [item objectForKey:@"driveflg"];
#endif
        dateStruct.month = self.mCurrDate.year;
        dateStruct.year =  self.mCurrDate.year;
        
        if([flag isEqualToString:@"1"]){
            /*
            if([uiDataDict objectForKey:flag] ==nil){
                
                NSMutableArray *data = [NSMutableArray arrayWithObject:[NSNumber numberWithBool:<#(BOOL)#>]];
                [uiDataDict setObject:data forKey:flag];
                
            }
            */
            NSString *value = [NSString stringWithFormat:@"%d",dateStruct.day];
            if(![driveOk isEqualToString:@""]){
                [driveOk appendString:@","];
            }
            [self.mHasDataDict setValue:@"" forKey:value];
            [driveOk appendString:value];
        }
        else{
            NSString *value = [NSString stringWithFormat:@"%d",dateStruct.day];
            if(![driveFailed isEqualToString:@""]){
                [driveFailed appendString:@","];
            }
            [self.mHasDataDict setValue:@"" forKey:value];
            [driveFailed appendString:value];
        }
    }
    
    NSArray *arrayData = [NSArray arrayWithObjects:
                          driveOk,
                          driveFailed, nil];
    [self performSelectorOnMainThread:@selector(perOnMainThreadFun:) withObject:arrayData waitUntilDone:NO];
    
}
- (void)perOnMainThreadFun:(NSArray*)data{
 
    calView = csView.getCurrentPageView;
    NSLog(@"%@",[calView getDateKey]);
    if(![[calView getDateKey]isEqualToString:self.mMothDateKey]){
        return;
    }
    if(isTodayMonth){
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *dateParts = [[NSDateComponents alloc] init];
        [dateParts setMonth:self.mTodayDate.month];
        [dateParts setYear:self.mTodayDate.year];
        [dateParts setDay:self.mTodayDate.day];
        
        NSDate *sDate = [calendar dateFromComponents:dateParts];
        SafeRelease(dateParts);
        SafeRelease(calendar);
        [calView addStartDate:sDate endDate:sDate withTag:2];
    }
    [self processData:data[0] withStatus:0];
    [self processData:data[1] withStatus:1];
   
    
    //        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    //Now we're going to optionally set the start and end date of a pre-selected range.
    //This is totally optional.
    
    //OCCalendarView *currView = [csView viewWithTag: ];
    NSString *barTitle  = [NSString stringWithFormat:@"%d年%02d月",self.mCurrDate.year,self.mCurrDate.month];
    [self setNavgationBarTitle:barTitle];
    [calView  setReLayoutView];
    isNeedReflush = NO;

}
//NSComparisonResult comparseData}
- (void)processData:(NSString*)data withStatus:(int)tag{

    if([data isEqualToString:@""])
        return;
    NSArray *okDateArray = [data componentsSeparatedByString:@","];
    okDateArray = [okDateArray sortedArrayUsingComparator:^(id arg1,id arg2){
        if([arg1 intValue]>[arg2 intValue]){
            return NSOrderedDescending;
        }
        else if([arg1 intValue]<[arg1 intValue]){
            return NSOrderedAscending;
        }
        else{
            return NSOrderedSame;
        }
    }
        ];
    int startDay = -1;
    int currDay = 0;
    int nextDay = 0;
    int endDay = -1;
    if([okDateArray count]){
        currDay = startDay = [okDateArray[0] intValue];
    }
    int i;
    for (i =0; i<[okDateArray count]; i++) {
        
        if(i+1<[okDateArray count]){
            nextDay = [okDateArray[i+1]intValue];
        }
        else{
            
            
            
        }
        if(currDay+1 == nextDay){
            currDay =nextDay;
        }
        else{
            [self doAddNormalStartDay:startDay endDay:currDay withStatus:tag];
            startDay = nextDay;
            currDay = nextDay;
        }
    }
    if(i !=[okDateArray count]){
        
        [self doAddNormalStartDay:startDay endDay:currDay withStatus:tag];
        
    }

}
- (void)doAddNormalStartDay:(int)sday endDay:(int)eday withStatus:(int)tag{

     NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateParts = [[NSDateComponents alloc] init];
    [dateParts setMonth:self.mCurrDate.month];
    [dateParts setYear:self.mCurrDate.year];
    [dateParts setDay:sday];
    
    NSDate *sDate = [calendar dateFromComponents:dateParts];
    [dateParts release];
    
    
    dateParts = [[NSDateComponents alloc] init];
    [dateParts setMonth:self.mCurrDate.month];
    [dateParts setYear:self.mCurrDate.year];
    [dateParts setDay:eday];
    
    NSDate *eDate = [calendar dateFromComponents:dateParts];
    [calView addStartDate:sDate endDate:eDate withTag:tag];
    SafeRelease(calendar);
    SafeRelease(dateParts);
}
#pragma mark -


@end
