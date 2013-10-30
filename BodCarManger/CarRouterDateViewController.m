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
@interface CarRouterDateViewController ()<OCCalendarDelegate>{
    OCCalendarView *calView;
   
    
}

@property(nonatomic,strong)NSMutableDictionary   *mHasDataDict;
@end

@implementation CarRouterDateViewController
@synthesize mHasDataDict;
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
    [self setHiddenLeftBtn:YES];
    
    self.mMothDateKey = [NSString stringWithFormat:@"%d%02d",self.mCurrDate.year,self.mCurrDate.month];
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"BG.png");
    mainView.bgImage = bgImage;

    
    UIImageWithFileName(bgImage, @"button-message.png");
    [super setNavgationBarRightBtnImage:bgImage forStatus:UIControlStateNormal];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
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

#if 0
    [calView setStartDate:sDate];
    [calView setEndDate:eDate];
#else
    //[calView addStartDate:sDate endDate:eDate];
#endif
    //[calView addStartDate:sDate endDate:sDate];
    
    [calView setDelegate:self];
    
//    [calVC setStartDate:sDate];
//    [calVC setEndDate:eDate];
    [self.view addSubview:calView];
#endif
    
    CGFloat currY = 250.f+40.f+50.f;
    UIImageWithFileName(bgImage, @"regular-small.png");
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:bgImage];
    [self.view addSubview:imageView];
    imageView.frame = CGRectMake(60.f,currY, bgImage.size.width/kScale, bgImage.size.height/kScale);
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(60.f+bgImage.size.width+7,currY-5,120.f,20.f)];
    label.text = @"正常行使日";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    
    currY = currY + 25;
    
    UIImageWithFileName(bgImage, @"faulty-small.png");
    
    imageView = [[UIImageView alloc]initWithImage:bgImage];
    [self.view addSubview:imageView];
    imageView.frame = CGRectMake(60.f,currY, bgImage.size.width/kScale, bgImage.size.height/kScale);

    label = [[UILabel alloc]initWithFrame:CGRectMake(60.f+bgImage.size.width+7,currY-5,120.f,20.f)];
    label.text = @"报警日/故障日";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    
    
	// Do any additional setup after loading the view.
}
#pragma mark -
#pragma mark - choose day
- (void)didChooseCalendarDay:(NSDictionary*)day{
    
    
//    if(![self.mHasDataDict objectForKey:[day objectForKey:@"day"]]){
//        
//        return;
//        
//    }
    
    NSString *title = [NSString stringWithFormat:@"%@/%@/%@",[day objectForKey:@"year"],[day objectForKey:@"month"],[day objectForKey:@"day"]];
    
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
 
    [self processData:data[0] withStatus:0];
    [self processData:data[1] withStatus:1];
    
    //        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    //Now we're going to optionally set the start and end date of a pre-selected range.
    //This is totally optional.
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
            return -1;
        }
        else{
            return 0;
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
    for (int i =0; i<[okDateArray count]; i++) {
        
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
    if(currDay==startDay && nextDay!=0){
        
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
    [dateParts release];
    [calView addStartDate:sDate endDate:eDate withTag:tag];
}
@end
