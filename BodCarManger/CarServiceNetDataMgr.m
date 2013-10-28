//
//  DressMemoNetDataMgr.m
//  DressMemo
//
//  Created by  on 12-6-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CarServiceNetDataMgr.h"
#import "ZCSNetClientNetInterfaceMgr.h"
#import "ZCSNetClientConfig.h"
#import "ZCSNetClient.h"
#import "AppSetting.h"
#import <iPlat4M_framework/iPlat4M_framework.h>
//#import "AppConfig_bak.h"
@interface CarServiceNetDataMgr()
@property(nonatomic,retain)NSMutableDictionary *requestResourceDict;
//@property(nonatomic,assign)BOOL isUserLogOut;
@end
static CarServiceNetDataMgr *sharedInstance = nil;
static ZCSNetClientNetInterfaceMgr *dressMemoInterfaceMgr = nil;
@implementation CarServiceNetDataMgr
@synthesize requestResourceDict;
+(id)getSingleTone{
    @synchronized(self)
    {
        if(sharedInstance == nil)
            sharedInstance = [[self alloc] init];
        
    }
    return sharedInstance;
}
-(id)init
{
    if(self = [super init])
    {
        dressMemoInterfaceMgr = [ZCSNetClientNetInterfaceMgr getSingleTone];
        NSDictionary *requestResouceMapDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                               
                                               @"login",        kNetLoginRes,
                                               @"register",             kNetResignRes,
                                               @"search_goods", @"getgoodslist",
                                               @"search_goodDetail",@"getGoodDetail",
                                               @"search_orders_old",@"search_orders_old",
                                               @"search_orders_month",@"search_orders_month",
                                               @"search_good_ad",@"getGoodAd",
                                               @"search_good_ad",@"getGoodMap",
                                               @"search_category",@"search_category",
                                               @"search_orders",@"search_orders",
                                               @"search_ordergoods",@"search_ordergoods",
                                               @"search_orderDetail",@"search_orderDetail",
                                               @"search_fav",@"search_fav",
                                               @"search_delivery",@"search_delivery",
                                               @"pay",@"pay",
                                               
                                               @"search_address",@"search_address",
                                               @"add_address",@"add_address",
                                               @"edit_address",@"edit_address",
                                               
                                               @"search_province",@"search_province",
                                               @"search_city",@"search_city",
                                               @"search_good_map",@"search_good_map",
                                               
                                               @"delete_order",@"delete_order",
                                               @"update",       @"update",
                                               @"getsms",       @"getsms",
                                               @"update_contacts",@"update_contacts",
                                               @"getsmsfindpassword",@"getsmsfindpassword",
                                               @"findpassword",@"findpassword",
                                               
                                               @"new_order",    @"new_order",
                                               @"search_ad",@"search_ad",
                                               @"search_good_ad",@"search_good_ad",
                                               @"search_good_map",@"search_good_map",
                                               @"update_userico",@"update_userico",
                                                   @"search_deliveryDetail",@"search_deliveryDetail",
                                               @"getDetailByDay",@"getDetailByDay",
                                               @"getInfoByMonth",@"getInfoByMonth",
                                               nil];
        dressMemoInterfaceMgr.requestResourceDict = requestResouceMapDict;
        
        dressMemoInterfaceMgr.netInterfaceDataSource = self;
        dressMemoInterfaceMgr.netInterfaceDelegate = self;
        //requestResourceDict = [[NSMutableDictionary alloc]init];
#if 0
        [ZCSNotficationMgr addObserver:self call:@selector(didGetDataFromNet:) msgName:kZCSNetWorkOK];
        [ZCSNotficationMgr addObserver:self call:@selector(didGetDataFromNetFailed:) msgName:kZCSNetWorkRequestFailed];
#endif
        //dbMgr = [DBManage getSingleTone];
    }
    return self;
}

#pragma mark -
#pragma mark user
- (id)carUserLogin:(NSDictionary *)param{
    EiInfo *inInfo = [self getCommIPlant4MParam];
    [inInfo set:@"name" value:[param objectForKey:@"name"]];
    [inInfo set:@"password" value:[param objectForKey:@"password"]];
    //queryTripCalanderMonth
    [inInfo set:METHOD_TOKEN value:@"queryTripCalanderMonth"]; // 接口名
    [self startiPlant4MRequest:inInfo withSuccess:@selector(userLoginOk:) withFailed:@selector(userLoginFailed:)];
}
- (id)carUserRegister:(NSDictionary*)param{
    EiInfo *inInfo = [self getCommIPlant4MParam];
    [inInfo set:@"name" value:[param objectForKey:@"name"]];
    [inInfo set:@"password" value:[param objectForKey:@"password"]];
    //queryTripCalanderMonth
    [inInfo set:METHOD_TOKEN value:@"queryTripCalanderMonth" ]; // 接口名
    [self startiPlant4MRequest:inInfo withSuccess:@selector(userRegisterOk:) withFailed:@selector(userRegisterFailed:)];
}
#pragma mark -
#pragma mark rounter
- (id)getDetailByMonth:(NSDictionary*)param{
#if BAO_TEST
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"getInfoByMonth"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"POST"
                                                withData:NO];
#else
    EiInfo *inInfo = [self getCommIPlant4MParam];
    [inInfo set:@"year" value:[param objectForKey:@"year"]];
    [inInfo set:@"month" value:[param objectForKey:@"month"]];
    //queryTripCalanderMonth
    [inInfo set:METHOD_TOKEN value:@"queryTripCalanderMonth"]; // 接口名
    [self startiPlant4MRequest:inInfo];
#endif
    
}
- (id)getDetailByDay:(NSDictionary*)param{
#if BAO_TEST
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"getDetailByDay"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"POST"
                                            withData:NO];
#else
    EiInfo *inInfo = [self getCommIPlant4MParam];
    [inInfo set:METHOD_TOKEN value:@"queryTripDay"]; // 接口名
    [inInfo set:@"year" value:[[NSNumber alloc] initWithInt:2013]]; // 设置参数
    [inInfo set:@"month" value:[[NSNumber alloc] initWithInt:10]];
    [inInfo set:@"day" value:[[NSNumber alloc] initWithInt:16]];
    [inInfo set:@"vin" value:@"SHD49232"];
    [self startiPlant4MRequest:inInfo];
#endif
}
- (id)getRouterRealTimeData:(NSString*)cardId{
    cardId = @"SHD05728";
    //cardId = @"SHD49232";
    //SHD05728
    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VEMT02"];
    //[inInfo set:@"year" value:[param objectForKey:@"year"]];
    //[inInfo set:SERVICE_TOKEN  value:@"VEMT02"]
    [inInfo set:METHOD_TOKEN value:@"queryTripNow"]; // 接口名
    [inInfo set:@"vin" value:cardId];
    [self startiPlant4MRequest:inInfo withSuccess:@selector(getRouterRealTimeDataOk:) withFailed:@selector(getRouterRealTimeDataFaild:)];
}
- (id)getRouterLatestData:(NSString*)cardId{
    //queryLastTripID
    EiInfo *inInfo = [self getCommIPlant4MParam];
    //[inInfo set:@"year" value:[param objectForKey:@"year"]];
    [inInfo set:METHOD_TOKEN value:@"queryLastTripID"]; // 接口名
    //[inInfo set:@"vin" value:cardId];
    [self startiPlant4MRequest:inInfo withSuccess:@selector(getRouterLatestDataOk:) withFailed:@selector(getRouterLatestDataFaild:)];
}
- (id)getRouterHistoryData:(NSString*)cardId{
    //queryTripHistory
    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VEMT02"];
    //[inInfo set:@"year" value:[param objectForKey:@"year"]];
    //[inInfo set:SERVICE_TOKEN  value:@"VEMT02"]
    [inInfo set:METHOD_TOKEN value:@"queryTripHistory"]; // 接口名
    [inInfo set:@"vin" value:cardId];
    [self startiPlant4MRequest:inInfo withSuccess:@selector(getRouterHistoryDataOk:) withFailed:@selector(getRouterHistoryDataFailed:)];
}
- (id)getRouterDataByMonth:(NSString*)month withYear:(NSString*)year{
    //queryDriveMonthData
    year = @"2013";
    month = @"10";
    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VESA01"];
    //[inInfo set:@"year" value:[param objectForKey:@"year"]];
    [inInfo set:METHOD_TOKEN value:@"queryTripCalanderMonth"]; // 接口名
    //[inInfo set:@"vin" value:cardId];
    [inInfo set:@"year" value:year]; // 设置参数
    [inInfo set:@"month" value:month];
    //[inInfo set:@"day" value:[[NSNumber alloc] initWithInt:16]];
    [self startiPlant4MRequest:inInfo withSuccess:@selector(getRouterDataByMonthOk:) withFailed:@selector(getRouterDataByMonthFailed:)];
}
- (id)getRouterDataByDay:(NSString*)day withMoth:(NSString*)month withYear:(NSString*)year{
    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VESA01"];
    [inInfo set:METHOD_TOKEN value:@"queryTripDay"]; // 接口名
    [inInfo set:@"year" value:[[NSNumber alloc] initWithInt:2013]]; // 设置参数
    [inInfo set:@"month" value:[[NSNumber alloc] initWithInt:10]];
    [inInfo set:@"day" value:[[NSNumber alloc] initWithInt:16]];
    [inInfo set:@"vin" value:@"SHD49232"];
    [self startiPlant4MRequest:inInfo];
}

#pragma mark -
#pragma mark drive model
#define Drive_TEST

- (id)getDriveDataByCarId:(NSString*)cardId withMonth:(NSString*)month withYear:(NSString*)year{
    //queryDriveMonthData
#ifdef Drive_TEST
    year = @"2013";
    month = @"10";
    cardId = @"SHD05728";
#endif
    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VESA01"];
    inInfo.name = @"queryDriveMonthData";
    //[inInfo set:@"year" value:[param objectForKey:@"year"]];
    [inInfo set:METHOD_TOKEN value:@"queryDriveMonthData"]; // 接口名
    [inInfo set:@"vin" value:cardId];
    [inInfo set:@"year" value:year]; // 设置参数
    [inInfo set:@"month" value:month];
    //[inInfo set:@"day" value:[[NSNumber alloc] initWithInt:16]];
    [self startiPlant4MRequest:inInfo withSuccess:@selector(getDriveDataOk:) withFailed:@selector(getDriveDataFailed:)];
}
- (id)getDriveActionAnalysisDataByCarId:(NSString*)cardId withMoth:(NSString*)month withYear:(NSString*)year{
#ifdef Drive_TEST
    year = @"2013";
    month = @"10";
    cardId = @"SHD05728";
#endif
    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VESA01"];
    [inInfo set:METHOD_TOKEN value:@"querySafeAnalyse"]; // 接口名
    
    [inInfo set:@"vin" value:cardId];
    [inInfo set:@"year" value:year]; // 设置参数
    [inInfo set:@"month" value:month];
    [self startiPlant4MRequest:inInfo withSuccess:@selector(getDriveActionAnalysisDataOk:) withFailed:@selector(getDriveActionAnalysisDataFaild:)];
}
- (id)getDriveOilAnalysisDataByCarId:(NSString*)cardId withMoth:(NSString*)month withYear:(NSString*)year{
#ifdef Drive_TEST
    year = @"2013";
    month = @"10";
    cardId = @"SHD05728";
#endif
    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VESA01"];
    [inInfo set:METHOD_TOKEN value:@"queryEconomicAnalyse"]; // 接口名
    [inInfo set:@"vin" value:cardId];
    [inInfo set:@"year" value:year]; // 设置参数
    [inInfo set:@"month" value:month];
    [self startiPlant4MRequest:inInfo withSuccess:@selector(getDriveOilAnalysisDataOk:) withFailed:@selector(getDriveOilAnalysisDataFailed:)];

}
#pragma mark -
#pragma mark car status
- (void)getCarMaintainanceData:(NSString*)cardId{
    EiInfo *inInfo = [self getCommIPlant4MParam];
    //[inInfo set:@"year" value:[param objectForKey:@"year"]];
    [inInfo set:METHOD_TOKEN value:@"queryMaintain"]; // 接口名
    //[inInfo set:@"vin" value:cardId];
    [self startiPlant4MRequest:inInfo withSuccess:@selector(getCarMaintainanceDataOk:) withFailed:@selector(getCarMaintainanceDataFailed:)];
}
- (id)getCarCheckData:(NSString*)cardId{
    //queryConData
    EiInfo *inInfo = [self getCommIPlant4MParam];
    //[inInfo set:@"year" value:[param objectForKey:@"year"]];
    [inInfo set:METHOD_TOKEN value:@"queryConData"]; // 接口名
    //[inInfo set:@"vin" value:cardId];
    [self startiPlant4MRequest:inInfo withSuccess:@selector(getCarCheckDataOk:) withFailed:@selector(getCarCheckDataFailed:)];
}

#pragma mark -
#pragma mark service
- (id)getMessageList:(NSDictionary*)param{
#if BAO_TEST
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"getDetailByDay"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"POST"
                                                withData:NO];
#else
    EiInfo *inInfo = [self getCommIPlant4MParam];
    //[inInfo set:@"year" value:[param objectForKey:@"year"]];
    [inInfo set:METHOD_TOKEN value:@"queryMessage"]; // 接口名
    //[inInfo set:@"vin" value:cardId];
    [self startiPlant4MRequest:inInfo withSuccess:@selector(getMessageListOk:) withFailed:@selector(getMessageListFailed:)];
    
#endif
}

#pragma mark -
#pragma mark iPlant4M common
- (EiInfo*)getCommIPlant4MParam{
    EiInfo *inInfo = [[EiInfo alloc] init];
    [inInfo set:PROJECT_TOKEN value:kBaoTApp]; // 固定
    [inInfo set:SERVICE_TOKEN value:@"VESA01"]; // 由IF所在位置决定，需要文档
    return SafeAutoRelease(inInfo);
}
- (EiInfo*)getCommIPlant4MParamByServiceToken:(NSString*)token{
    EiInfo *inInfo = [[EiInfo alloc] init];
    [inInfo set:PROJECT_TOKEN value:kBaoTApp]; // 固定
    [inInfo set:SERVICE_TOKEN value:token]; // 由IF所在位置决定，需要文档
    return SafeAutoRelease(inInfo);
}
- (void)testiPlant4MInterface{
    EiInfo *inInfo = [[EiInfo alloc] init];
    [inInfo set:PROJECT_TOKEN value:kBaoTApp]; // 固定
    [inInfo set:SERVICE_TOKEN value:@"VESA01"]; // 由IF所在位置决定，需要文档
#if 0
   
#else
    
#endif
    
}
- (void)startiPlant4MRequest:(EiInfo*)inInfo withSuccess:(SEL)sucCalFun withFailed:(SEL)failedCalFun{
    
    [[Container instance].serviceAgent
     callServiceWithObject:self
     inInfo:inInfo
     target:self
     successCallBack:sucCalFun//回调函数
     failCallBack:failedCalFun
     ]; // 失败时的回调
}
#pragma mark -
#pragma mark delegate user
- (void)userLoginOk:(EiInfo*)info{


}
- (void)userLoginFailed:(EiInfo*)info{


}
- (void)userRegisterOk:(EiInfo*)info{
    
    
}

- (void)userRegisterFailed:(EiInfo*)info{
    
    
}
#pragma mark -
#pragma mark delegate router

- (void)getRouterRealTimeDataOk:(EiInfo*)info{


}
- (void)getRouterRealTimeDataFailed:(EiInfo*)info{


}
- (void)getRouterLatestDataOkOk:(EiInfo*)info{
    
    
}
- (void)getRouterLatestDataFailed:(EiInfo*)info{
    
    
}
- (void)getRouterHistoryDataOk:(EiInfo*)info{
    
    
}
- (void)getRouterHistoryDataFailed:(EiInfo*)info{


}
- (void)getRouterDataByMonthOk:(EiInfo*)infor{

}
- (void)getRouterDataByMonthFailed:(EiInfo*)info{
    
    
}

- (void)getRouterDataByDayOk:(EiInfo*)infor{
    
}
- (void)getRouterDataByDayFailed:(EiInfo*)info{
    
    
}
#pragma mark -
#pragma mark drive delegate
- (void)getDriveDataOk:(EiInfo*)info{

}
- (void)getDriveDataFailed:(EiInfo*)info{


}
- (void)getDriveActionAnalysisDataOk:(EiInfo*)info{
    
}
- (void)getDriveActionAnalysisDataFaild:(EiInfo*)info{

}
- (void)getDriveOilAnalysisDataOk:(EiInfo*)info{
    
}
- (void)getDriveOilAnalysisDataFailed:(EiInfo*)info{
    
}
#pragma mark -
#pragma mark service delegate
- (void)getCarCheckDataOk:(EiInfo*)info{
    
}
- (void)getCarCheckDataFailed:(EiInfo*)info{
    
}

#pragma mark -
#pragma mark card status delegate

- (void)getMessageListOk:(EiInfo*)info{

}
- (void)getMessageListFailed:(EiInfo*)info{
    
}

- (void)getCarMaintainanceDataOk:(EiInfo*)info{
    
}
- (void)getCarMaintainanceDataFailed:(EiInfo*)info{
    
}
- (void)didQueryTripDaySuccess:(EiInfo*)info // 一般都必须有一个EiInfo参数
{
    if([info.name isEqualToString:@"queryDriveMonthData"]){
        NSLog(@"%@",info.name);
    }
    if(info.status == 1){
        NSNumber *dayMilage = [info get:@"dayMilage"]; // 取出返回值，非block的类型
        NSNumber *dayFuel = [info get:@"dayFuel"];
        NSNumber *dayDrivinglong = [info get:@"dayDrivinglong"];
        EiBlock *tripInfo = [info getBlock:@"tripInfo"]; // block型返回值
        int rowCount = [tripInfo getRowCount];
        NSMutableDictionary *row = [tripInfo getRow:0]; // block有多个row，每个为一个NSMutableDictionary对象
        NSNumber *tripId = [row objectForKey:@"tripId"]; // 通过objectForKey取出
    }
}

- (void)didQueryTripDayFailed:(EiInfo*)info
{  
    NSLog(@"Failed");  
}
@end
